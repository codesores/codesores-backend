class  IssuesController < ApplicationController
  # before_action :authenticate_user!

  def start
    @languages = Language.all.pluck(:language)
    render json: @languages
  end

  def index
    render json: @issues
  end

  def show
    issue = Issue.includes(:repo, :language, :user_feedbacks).find(params[:id])
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
