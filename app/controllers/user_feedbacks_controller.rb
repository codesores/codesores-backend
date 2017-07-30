class UserFeedbacksController < ApplicationController
  def create
    p "* " * 200
    p feedback_params
    @request_type = RequestType.where(scope: feedback_params[:request_type]).first
    p "--" * 10
    @feedback = UserFeedback.new(validity: feedback_params[:validity], difficulty: feedback_params[:difficulty], request_type: @request_type, issue_id: feedback_params[:issue_id], user: User.first) 

    #missing user id !!!

    @feedback.save!
    render json: ['hii']
  end



  private 
  def feedback_params
    params.require(:feedback).permit(:validity, :difficulty, :request_type, :issue_id)
  end
end
