@query = {
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

require 'net/http'
require 'uri'
require 'json'

# require 'json'

uri = URI.parse('https://api.github.com/graphql')
header = {'Content-Type': 'text/json'}


http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri, header)
request.body = user.to_json

# Send the request
response = http.request(request)
