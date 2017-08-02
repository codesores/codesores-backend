class  IssuesController < ApplicationController
  # before_action :authenticate_user!

  def start
    @languages = Language.all.pluck(:language)
    @issues = Issue.most_recent(10)
    # render json: @languages, @issues
    render :json => {
      :languages => @languages.as_json,
      :issues => @issues.as_json
    }
  end

  def index
    render json: @issues
  end

  def show
    issue = Issue.includes(:repo, :language, :user_feedbacks).find(params[:id])
    render json: issue
  end

  def search
    @issues = Issue.advanced_search(params['bugs'], params['documentation'], params['language'], params['difficulty'].to_i, params["keywords"])

    render json: @issues
  end

  def results
    render json: Issue.limit(10)
  end

end
