module GraphQLCalls

  Login = <<-'GRAPHQL'
  query {
    viewer {
      login
    }
  }
  GRAPHQL


  RailsRepo = <<-'GRAPHQL'
  query {
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


end