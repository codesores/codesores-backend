require_relative 'fake_server_response'


Repo.delete_all
Issue.delete_all

@javascript_repos[:data][:search][:edges].each do |repo|
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
  repo_updated_at: DateTime.parse(repo[:updatedAt])

  )

  repo_entry.save
  p repo_entry.name

end

[@modernizr_issues, @webpack_issues, @freecodecamp_issues].each do |repo|
  repo[:data][:repository][:issues][:edges].each do |issue|
    issue = issue[:node]

    issue_entry = Issue.new(
    title: issue[:title],
    labels: issue[:labels][:edges],
    body: issue[:body],
    issue_created_at: DateTime.parse(issue[:createdAt]),
    comment_count: issue[:comments][:totalCount],
    url: issue[:url],
    author: issue[:author][:login],
    participant_count: issue[:participants][:totalCount],
    assignee_count: issue[:assignees][:totalCount],
    repo_id: Repo.find_by(name: issue[:repository][:nameWithOwner].match(/\/.*/).to_s[(1..-1)]).id
    # issue[:repository][:nameWithOwner].match(/\/.*/).to_s[(1..-1)]
    )

    issue_entry.save
    issue_entry.title
  end

end


