require_relative 'fake_server_response'


Repos.delete_all
Issues.delete_all

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

@freecodecamp_issues[:data][:repository][:issues][:edges].each do |obj|

   obj.each do |key, value|
      p value[:title]
      p value[:labels][:edges]
      p value[:createdAt]
      p value[:comments][:totalCount]
      p value[:url]
      p value[:author][:login]
      p value[:participants][:totalCount]
      p value[:assignees][:totalCount]
      p value[:repository][:nameWithOwner].match(/\/.*/).to_s[(1..-1)]
   end
end

@webpack_issues[:data][:repository][:issues][:edges].each do |obj|

   obj.each do |key, value|
      p value[:title]
      p value[:labels][:edges]
      p value[:createdAt]
      p value[:comments][:totalCount]
      p value[:url]
      p value[:author][:login]
      p value[:participants][:totalCount]
      p value[:assignees][:totalCount]
      p value[:repository][:nameWithOwner].match(/\/.*/).to_s[(1..-1)]
   end
end

@modernizr_issues[:data][:repository][:issues][:edges].each do |obj|

   obj.each do |key, value|
      p value[:title]
      p value[:labels][:edges]
      p value[:createdAt]
      p value[:comments][:totalCount]
      p value[:url]
      p value[:author][:login]
      p value[:participants][:totalCount]
      p value[:assignees][:totalCount]
      p value[:repository][:nameWithOwner].match(/\/.*/).to_s[(1..-1)]
   end
end

