class UserFeedbacksController < ApplicationController
  def create
    p "* " * 200
    @feedback = UserFeedback.new(feedback_params)  
    @feedback.user = User.first               #missing user id !!!

    @feedback.save!
    render json: ['hii']
  end



  private 
  def feedback_params
    @params = params.require(:feedback).permit(:validity, :difficulty, :request_type, :issue_id)
    @request_type = RequestType.where(scope: @params[:request_type]).first
    @params[:request_type] = @request_type

    @params
  end
end
