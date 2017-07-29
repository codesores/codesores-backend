require_relative 'fake_server_response'

Repo.delete_all
Issue.delete_all

 @repos[:data][:search][:edges].each do |repo|
   repo = repo[:node]

   repo_entry = Repo.new(

   name: repo[:name],
   url: repo[:url],
   owner: repo[:owner][:login],
   description: repo[:description],
   language: repo[:primaryLanguage][:name],
   mentionable_user_count: repo[:mentionableUsers][:totalCount],
   stargazers_count: repo[:stargazers][:totalCount],
   issues_count: repo[:issues][:totalCount],
   forks_count: repo[:forks][:totalCount],
   pull_request_count: repo[:pullRequests][:totalCount],
   repo_updated_at: repo[:updatedAt]

   )

   repo_entry.save
   p repo_entry.name

 end