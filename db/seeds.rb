require_relative 'fake_server_response'

Repo.delete_all
Issue.delete_all
RequestType.delete_all
UserFeedback.delete_all
User.delete_all

User.create(login: "octocat", name: "The Octocat", avatar_url: "https://avatars3.githubusercontent.com/u/583231?v=4&s=460")

[@ruby_repos, @javascript_repos].each do |language|
  language[:data][:search][:edges].each do |repo|
    repo = repo[:node]
    standardized_language = repo[:primaryLanguage][:name].downcase.gsub(/\s/,"_")

    repo_entry = Repo.new(

    name: repo[:name],
    url: repo[:url],
    owner: repo[:owner][:login],
    description: repo[:description],
    language_id: Language.find_or_create_by(language: standardized_language).id,
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
end

RequestType.create(scope: 'bug')
RequestType.create(scope: 'docs')
RequestType.create(scope: 'other')


[@modernizr_issues, @webpack_issues, @freecodecamp_issues, @rails_issues].each do |repo|
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
    repo_id: Repo.find_by(name: issue[:repository][:nameWithOwner].match(/\/.*/).to_s[(1..-1)]).id,
    request_type_id: rand(1..3)
    # issue[:repository][:nameWithOwner].match(/\/.*/).to_s[(1..-1)]
    )

    issue_entry.save
    issue_entry.title
  end

end

Issue.all.each do |issue|
  20.times do
    input = UserFeedback.new(
      user_id: User.first.id,
    issue_id: issue.id,
    validity: rand(0..1),
    difficulty: rand(1..5)
    )
    p input.valid?
    p input.errors.full_messages
    input.save
  end
end
