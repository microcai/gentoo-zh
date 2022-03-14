async function getSearchIssuesResult(github, context, page_number = 1) {
  titleSearchKeyword = "[nvchecker] can be bump to";
  searchQuery = `repo:${process.env.GITHUB_REPOSITORY} is:issue in:title ${titleSearchKeyword}`;
  const searchIssues = await github.rest.search.issuesAndPullRequests({
    q: searchQuery,
    per_page: 100,
    page: page_number,
  });
  return searchIssues.data.items;
}

function getGithubAccount(package) {
  var toml = require("toml");
  var fs = require("fs");
  var tomlFileContent = fs.readFileSync(
    ".github/workflows/overlay.toml",
    "utf8"
  );

  github_account = toml.parse(tomlFileContent)[package]["github_account"];

  return github_account;
}

module.exports = async ({ github, context, core }) => {
  let issuesData = [];
  let index = 0;
  while (true) {
    index++;
    try {
      const response = await getSearchIssuesResult(
        github,
        context,
        (page_number = index)
      );
      issuesData = issuesData.concat(response);
      if (response.length < 100) {
        break;
      }
    } catch (error) {
      core.warning(`Waring ${error}, action may still succeed though`);
    }
  }

  let pkgs = JSON.parse(process.env.pkgs);
  for (let pkg of pkgs) {
    // // limit "x11-misc/9menu" and "dev-libs/libthai"
    // if (pkg.name != "x11-misc/9menu" && pkg.name != "dev-libs/libthai") {
    //   continue;
    // }

    titlePrefix = "[nvchecker] " + pkg.name + " can be bump to ";
    title = titlePrefix + pkg.newver;
    var body = "";
    if (pkg.oldver != null) {
      body += "oldver: " + pkg.oldver;
    }

    // append @github_account to body
    github_accounts = getGithubAccount(pkg.name);
    // if (github_accounts) {
    if (typeof github_accounts == "object") {
      body += "\nCC: ";
      for (let github_account of github_accounts) {
        body += " @" + github_account;
      }
    } else if (typeof github_accounts == "string") {
      body += "\nCC: @" + github_accounts;
    }
    // }

    // if body still empty, convert to null
    // because github rest api response's issue body is null, they should be same
    if (body == "") {
      body = null;
    }

    (async function () {
      // search existed in issues
      for (let issueData of issuesData) {
        // if titlePrefix matched
        if (
          issueData.title.length >= titlePrefix.length
            ? issueData.title.substring(0, titlePrefix.length) == titlePrefix
            : false
        ) {
          // titlePrefix matched;
          if (issueData.body == body && issueData.title == title) {
            // if body and title all matched, goto next loop
            return;
          } else {
            // if body or title not matched
            if (issueData.state == "open") {
              // if state is open, edit it, then goto next loop
              const issueUpdate = await github.rest.issues.update({
                owner: context.repo.owner,
                repo: context.repo.repo,
                issue_number: issueData.number,
                title: title,
                body: body,
              });
              console.log("Edit issue on %s", issueUpdate.data.html_url);
              return;
            } else {
              // if state is clsoe,create new
              break;
            }
          }
        }
      }
      try {
        // create new issue
        const issuesCreate = await github.rest.issues.create({
          owner: context.repo.owner,
          repo: context.repo.repo,
          title: title,
          body: body,
          labels: ["nvchecker"],
        });
        console.log("Created issue on %s", issuesCreate.data.html_url);
      } catch (error) {
        core.warning(`Waring ${error}, action may still succeed though`);
      }
    })();
  }
};
