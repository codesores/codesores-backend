class  IssuesController < ApplicationController
  # before_action :authenticate_user!

  def start
    @languages = Language.all.pluck(:language).unshift('Languages')
    render json: @languages
  end

  def index
    render json: @issues
  end

  def show
    issue = Issue.find(params[:id])
    issue = issue.attributes
    repo = Repo.find(issue['repo_id'])
    issue[:repo_name] = repo['name']
    issue[:repo_owner] = repo['owner']
    issue[:repo_language] = repo['language']
    issue[:repo_description] = repo['description']

    render json: issue
  end

  def search
    @language = Language.find_by(language: params[:language])
    @issues = Issue.joins(:repo).where("repos.language_id = #{@language.id}")

    render json: @issues
  end

  def results
    render json: Issue.limit(10)
  end

end
