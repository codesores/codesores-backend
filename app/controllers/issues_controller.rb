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
    render json: {issue: issue, feedbacks: issue.user_feedbacks, repo: issue.repo, stars: issue.stars}
  end

  def search
    @issues = Issue.advanced_search(params['bugs'], params['documentation'], params['language'], params['difficulty'].to_i, params["keywords"])

    render json: @issues.as_json(include: :repo)
  end

  def results
    render json: Issue.limit(10)
  end

end
