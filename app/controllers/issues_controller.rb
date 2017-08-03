class  IssuesController < ApplicationController
  # before_action :authenticate_user!

  def start
    @languages = Language.all.pluck(:language)
    # @issues = Issue.most_recent(10)
    @issues = Issue.hot_issues
    render json: {
      languages: @languages.as_json,
      issues: @issues.as_json(include: :repo)
    }
  end

  def index
    @issues = Issue.includes(:repo).limit(20)
    render json: {issues: @issues, repo: @issues.repo}
  end

  def show
    issue = Issue.includes(:repo, :language, :user_feedbacks, :stars).find(params[:id])
    feedback = {
      count: issue.user_feedbacks.count,
      average_validity: issue.user_feedbacks.average(:validity),
      average_difficulty: issue.user_feedbacks.average(:difficulty)
    }
    render json: {issue: issue, feedbacks: feedback, language: issue.language.language, repo: issue.repo, stars: issue.stars, request_type: RequestType.find(issue.request_type_id)}
  end

  def search
    @issues = Issue.advanced_search(params['bugs'], params['documentation'], params['features'], params['other'], params['language'], params['difficulty'].to_i, params["keywords"])

    render json: @issues.as_json(include: :repo)
  end

  def results
    render json: Issue.limit(10)
  end

end
