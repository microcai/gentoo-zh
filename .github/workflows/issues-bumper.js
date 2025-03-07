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

function randomSort(a, b) {
  return 0.5 - Math.random();
}

module.exports = async ({ github, context, core }) => {
  // hardcode gentoo-zh official repo name
  var gentoo_zh_official_repo_name = "microcai/gentoo-zh";
  var repo_name = process.env.GITHUB_REPOSITORY;
  var repo_is_gentoo_zh_official = repo_name == gentoo_zh_official_repo_name;

  let pkgs = JSON.parse(process.env.pkgs);
  const SEARCH_MAX_REMAINING = 30;
  var pkgs_gt_search_limit = pkgs.length > SEARCH_MAX_REMAINING;

  if (pkgs_gt_search_limit) {
    pkgs.sort(randomSort);
  }

  for (let pkg of pkgs) {
    // // limit "x11-misc/9menu" and "dev-libs/libthai"
    // if (pkg.name != "x11-misc/9menu" && pkg.name != "dev-libs/libthai") {
    //   continue;
    // }
    if (pkgs_gt_search_limit) {
      const { data: rate_limit_data } = await github.request("/rate_limit");
      if (rate_limit_data.resources.search.remaining == 0) {
        core.warning(`cause rate limit, failed to search ${pkg.name}'s issues`);
        break;
      }
    }

    titlePrefix = "[nvchecker] " + pkg.name + " can be bump to ";
    title = titlePrefix + pkg.newver;
    var body = "";
    if (pkg.oldver != null) {
      body += "oldver: " + pkg.oldver;
    }

    // append @github_account to body
    // only mention user on official gentoo-zh repo
    github_accounts = getGithubAccount(pkg.name);
    if (typeof github_accounts == "object") {
      // multiple accounts example:
      // github_account = ["st0nie", "peeweep"]
      body += "\nCC:";
      for (let github_account of github_accounts) {
        body += repo_is_gentoo_zh_official
          ? " @" + github_account
          : " " + github_account
      }
    } else if (typeof github_accounts == "string") {
      // single account example:
      // github_account = "peeweep"
      body += repo_is_gentoo_zh_official
        ? "\nCC: @" + github_accounts
        : "\nCC: " + github_accounts
    }

    // if body still empty, convert to null
    // because github rest api response's issue body is null, they should be same
    if (body == "") {
      body = null;
    }

    // search issues by titlePrefix
    let issuesData = [];
    let page_number = 0;
    // repo_name = "microcai/gentoo-zh";
    searchQuery = `repo:${repo_name} is:issue label:nvchecker in:title ${titlePrefix}`;
    while (true) {
      page_number++;
      try {
        const searchIssues = await github.rest.search.issuesAndPullRequests({
          q: searchQuery,
          per_page: 100,
          page: page_number,
          advanced_search: "true",
        });
        response = searchIssues.data.items;

        issuesData = issuesData.concat(response);
        if (response.length < 100) {
          break;
        }
      } catch (error) {
        core.warning(`failed to search issues with title: ${searchQuery}`);
        throw error;
      }
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
              // if (!repo_is_gentoo_zh_official) {
              //   // only update on official gentoo-zh repo
              //   return;
              // }
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
        core.warning(`failed to create issues with title: ${title}`);
        throw error;
      }
    })();
  }
};
