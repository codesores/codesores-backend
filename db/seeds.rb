require_relative 'fake_server_response'
require 'uri'
require 'net/http'
require 'json'


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
    repo_name: issue[:repository][:nameWithOwner].match(/\/.*/).to_s[(1..-1)],
    request_type_id: rand(1..3)
    # issue[:repository][:nameWithOwner].match(/\/.*/).to_s[(1..-1)]
    )

    issue_entry.save
    issue_entry.title
  end

end

Issue.all.each do |issue|
  # Obtain validity predicted
  nlc_text_input = issue.title.tr('^A-Za-z0-9', ' ')
  url = URI("https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/1c5f1ex204-nlc-102709/classify?text=#{nlc_text_input}")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)
  request["authorization"] = 'Basic MjM1Mzk1ZDctYWUzOC00OGY2LThiNDktNDdlYmVhM2MxOTJlOlVvVFpVMEdMYXJKbA=='
  request["cache-control"] = 'no-cache'
  request["postman-token"] = '9e748e3b-4331-2f4b-d4e4-8a2091328555'

  response = http.request(request)
  response_body = response.read_body
  p "Issue: #{issue.id}"
  p result = JSON.parse(response_body)
  p result["top_class"].to_i

  20.times do
    input = UserFeedback.new(
      user_id: User.first.id,
    issue_id: issue.id,
    validity: rand(0..1),
    difficulty: result["top_class"].to_i
    )
    p input.valid?
    p input.errors.full_messages
    input.save
  end
end
