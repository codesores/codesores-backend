query = <<-GRAPHQL
  {
  search(query: "language:JavaScript stars:>10000", type: REPOSITORY, first: 10) {
    repositoryCount
    edges {
      node {
        ... on Repository {
          name
          url
          owner {
            id
            login
          }
          nameWithOwner
          description
          primaryLanguage {
            name
          }
          mentionableUsers {
            totalCount
          }
          stargazers {
            totalCount
          }
          issues {
            totalCount
          }
          forks {
            totalCount
          }
          pullRequests {
            totalCount
          }
          updatedAt
        }
      }
    }
  }
}
GRAPHQL

query = query.gsub("\n",'')

check_rate = <<-GRAPHQL
query {
  viewer {
    login
  }
  rateLimit {
    limit
    cost
    remaining
    resetAt
  }
}
GRAPHQL

check_rate = check_rate.gsub("\n",'')

schema = <<-GRAPHQL
query {
  __schema {
    types {
      name
      kind
      description
      fields {
        name
      }
    }
  }
}
GRAPHQL




