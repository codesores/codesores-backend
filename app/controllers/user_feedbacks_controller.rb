class UserFeedbacksController < ApplicationController
  def create
    p "* " * 200
    p feedback_params
    @request_type = RequestType.where(scope: feedback_params[:type]).first
    p "--" * 10
    @feedback = UserFeedback.new(validity: feedback_params[:validity], difficulty: feedback_params[:difficulty], request_type: @request_type, user: User.first)   

    @feedback.save!
    render json: ['hii']
  end



  private 
  def feedback_params
    params.require(:feedback).permit(:validity, :difficulty, :type)
  end
end
