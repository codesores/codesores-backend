require_relative 'fake_server_response'

Repos.delete_all
Issues.delete_all

 @repos[:data][:search][:edges].each do |repo|
   repo = repo[:node]

   Repo.new(
   :name=>"freeCodeCamp",
   :url=>"https://github.com/freeCodeCamp/freeCodeCamp",
   :owner[:login],
   :description=>"The https://freeCodeCamp.com open source codebase and curriculum. Learn to code and help nonprofits.",
   :primaryLanguage=>{:name=>"JavaScript"},
   :mentionableUsers[:totalCount]
   :stargazers[:totalCount]
   :issues=[:totalCount]
   :forks[:totalCount]
   :pullRequests[:totalCount]
   :updatedAt=>"2017-07-28T21:18:32Z"}
   )

 end