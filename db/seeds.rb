require_relative 'fake_server_response'
require 'uri'
require 'net/http'
require 'json'

# Delete previous seed data
Repo.delete_all
Issue.delete_all
RequestType.delete_all
UserFeedback.delete_all
User.delete_all

# Seed fake users
User.create(login: "octocat", name: "Octocat", avatar_url: "https://avatars3.githubusercontent.com/u/583231?v=4&s=460")

User.create(login: "octocat2", name: "Octocat II", avatar_url: "https://avatars3.githubusercontent.com/u/583231?v=4&s=460")

User.create(login: "octocat3", name: "Octocat III", avatar_url: "https://avatars3.githubusercontent.com/u/583231?v=4&s=460")

User.create(login: "octocat4", name: "Octocat IV", avatar_url: "https://avatars3.githubusercontent.com/u/583231?v=4&s=460")

User.create(login: "octocat5", name: "Octocat V", avatar_url: "https://avatars3.githubusercontent.com/u/583231?v=4&s=460")

# Seed request types
RequestType.create(scope: 'bug')
RequestType.create(scope: 'docs')
RequestType.create(scope: 'feature')
RequestType.create(scope: 'other')

# Seed repos
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

# Seed issues
[@modernizr_issues, @webpack_issues, @freecodecamp_issues, @rails_issues].each do |repo|
  repo[:data][:repository][:issues][:edges].each do |issue|
    issue = issue[:node]

    # Obtain predicted request_type_id using Watson API
    nlc_text_input = issue[:title].tr('^A-Za-z0-9', ' ')
    url = URI("https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/359f3fx202-nlc-259546/classify?text=#{nlc_text_input}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["authorization"] = 'Basic YjFmMWQzZmYtNDY2My00Y2ZlLWJmNmYtNWQyMmZjNWViODA3Om9DNEpKTkRVODNBdg=='
    request["cache-control"] = 'no-cache'
    request["postman-token"] = 'be679e6a-1db4-6bbe-f31b-c760037414a8'

    response = http.request(request)
    response_body = response.read_body
    p result = JSON.parse(response_body)
    p predicted_request_type = result["top_class"].to_i

    # Create issue instance
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
    repo_name: issue[:repository][:nameWithOwner].match(/\/.*/).to_s[(1..-1)],
    request_type_id: predicted_request_type
    # issue[:repository][:nameWithOwner].match(/\/.*/).to_s[(1..-1)]
    )

    issue_entry.save
    issue_entry.title
  end

end

# Seed user feedback
Issue.all.each do |issue|
  20.times do
    input = UserFeedback.new(
      user_id: User.all.sample.id,
      issue_id: issue.id,
      validity: rand(0..1),
      difficulty: rand(1..5),
      request_type_id: rand(1..4)
    )
    p input.valid?
    p input.errors.full_messages
    input.save
  end
end

# Seed user stars
User.all.each do |user|
  all_issue_id = Issue.all.pluck(:id)
  15.times do
    select_issue_id = all_issue_id.sample
    star = Star.new(
    user_id: user.id,
    issue_id: select_issue_id
    )
    all_issue_id.delete(select_issue_id)
  end
end
