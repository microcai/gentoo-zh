const { graphql } = require("@octokit/graphql");
const fs = require("fs");
const toml = require("toml");

function getGithubAccount(packageName) {
  const tomlFileContent = fs.readFileSync(
    ".github/workflows/overlay.toml",
    "utf8"
  );
  return toml.parse(tomlFileContent)[packageName]["github_account"];
}

async function searchLimit(graphqlWithAuth) {
  const query = `
    query {
      rateLimit {
        remaining
      }
    }
  `;
  const { rateLimit } = await graphqlWithAuth(query);
  if (rateLimit.remaining === 0) {
    console.warn("Rate limit exceeded.");
    return true;
  }
  return false;
}

module.exports = async ({ github, context, core }) => {
  const graphqlWithAuth = graphql.defaults({
    headers: {
      authorization: `token ${process.env.GITHUB_TOKEN}`,
    },
  });

  if (await searchLimit(graphqlWithAuth)) {
    return;
  }

  const gentooZhOfficialRepoName = "microcai/gentoo-zh";
  const repoName = process.env.GITHUB_REPOSITORY;
  const repoIsGentooZhOfficial = repoName === gentooZhOfficialRepoName;

  const pkg = {
    name: process.env.name,
    newver: process.env.newver,
    oldver: process.env.oldver,
  };

  const titlePrefix = `[nvchecker] ${pkg.name} can be bump to `;
  const title = titlePrefix + pkg.newver;
  let body = pkg.oldver ? `oldver: ${pkg.oldver}` : "";

  const githubAccounts = getGithubAccount(pkg.name);
  if (Array.isArray(githubAccounts)) {
    body += "\nCC:" + githubAccounts.map((account) => (repoIsGentooZhOfficial ? ` @${account}` : ` ${account}`)).join("");
  } else if (typeof githubAccounts === "string") {
    body += repoIsGentooZhOfficial ? `\nCC: @${githubAccounts}` : `\nCC: ${githubAccounts}`;
  }

  if (!body) {
    body = null;
  }

  const searchQuery = `
    query($searchQuery: String!, $cursor: String) {
      search(query: $searchQuery, type: ISSUE, first: 100, after: $cursor) {
        issueCount
        edges {
          node {
            ... on Issue {
              number
              title
              body
              state
            }
          }
        }
        pageInfo {
          endCursor
          hasNextPage
        }
      }
    }
  `;

  const variables = {
    searchQuery: `repo:${repoName} is:issue label:nvchecker in:title ${titlePrefix}`,
    cursor: null,
  };

  let issuesData = [];
  do {
    const { search } = await graphqlWithAuth(searchQuery, variables);
    issuesData = issuesData.concat(search.edges.map((edge) => edge.node));
    variables.cursor = search.pageInfo.endCursor;
  } while (variables.cursor);

  for (const issue of issuesData) {
    if (issue.title.startsWith(titlePrefix)) {
      if (issue.body === body && issue.title === title) {
        return;
      } else if (issue.state === "OPEN") {
        await github.rest.issues.update({
          owner: context.repo.owner,
          repo: context.repo.repo,
          issue_number: issue.number,
          title: title,
          body: body,
        });
        console.log(`Updated issue: ${issue.number}`);
        return;
      }
    }
  }

  try {
    const createIssueMutation = `
      mutation($title: String!, $body: String, $repoId: ID!) {
        createIssue(input: {title: $title, body: $body, repositoryId: $repoId}) {
          issue {
            url
          }
        }
      }
    `;

    const repoQuery = `
      query($owner: String!, $name: String!) {
        repository(owner: $owner, name: $name) {
          id
        }
      }
    `;

    const { repository } = await graphqlWithAuth(repoQuery, {
      owner: context.repo.owner,
      name: context.repo.repo,
    });

    const { createIssue } = await graphqlWithAuth(createIssueMutation, {
      title: title,
      body: body,
      repoId: repository.id,
    });

    console.log(`Created issue: ${createIssue.issue.url}`);
  } catch (error) {
    core.warning(`Failed to create issue: ${error.message}`);
    throw error;
  }
};