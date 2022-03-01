async function getSearchIssuesResult(github, context, page_number = 1) {
  titleSearchKeyword = "[nvchecker] can be bump to";
  searchQuery = `repo:${context.payload.repository.full_name} is:issue in:title ${titleSearchKeyword}`;
  const searchIssues = await github.rest.search.issuesAndPullRequests({
    q: searchQuery,
    per_page: 100,
    page: page_number,
  });
  return searchIssues.data.items;
}

module.exports = async ({ github, context }) => {
  let issuesData = [];
  let index = 0;
  while (true) {
    index++;
    const response = await getSearchIssuesResult(
      github,
      context,
      (page_number = index)
    );
    issuesData = issuesData.concat(response);
    if (response.length < 100) {
      break;
    }
  }

  // console.log("Limit [nvchecker] fuo-qqmusic can be bump to 0.4");

  let pkgs = JSON.parse(process.env.pkgs);
  for (let pkg of pkgs) {
    delta = pkg.delta;
    name = pkg.name;
    newver = pkg.newver;
    titlePrefix = "[nvchecker] " + pkg.name + " can be bump to ";
    title = titlePrefix + pkg.newver;
    var body = "";
    if (pkg.oldver != null) {
      body = "oldver: " + pkg.oldver;
    }
    // // limit "dev-python/fuo-qqmusic"
    // if (pkg.name != "dev-python/fuo-qqmusic") {
    //   continue;
    // }

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
      // create new issue
      const issuesCreate = await github.rest.issues.create({
        owner: context.repo.owner,
        repo: context.repo.repo,
        title: title,
        body: body,
        labels: ["nvchecker"],
      });
      console.log("Created issue on %s", issuesCreate.data.html_url);
    })();
  }
};
