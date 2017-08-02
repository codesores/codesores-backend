class StarsController < ApplicationController
  before_action :authenticate_user!

  def create
    @issue = Issue.find_by(id: params[:issue_id])
    @star = Star.create(issue: @issue, user: current_user)
    render json: ['Created!']
  end

  def delete
    @issue = Issue.find_by(id: params[:issue_id])
    @star = Star.where(issue: @issue, user: current_user)
    @star.first.delete 
    render json: ['Deleted!']
  end

end
