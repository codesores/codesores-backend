class UserFeedbacksController < ApplicationController
  # before_action :authenticate_user!

  def create
    p "* " * 200
    @feedback = UserFeedback.new(feedback_params)
    @feedback.user = current_user

    @feedback.save!
    render json: ['hii']
  end



  private
  def feedback_params
    @params = params.require(:feedback).permit(:validity, :difficulty, :request_type, :issue_id)
    # @request_type = RequestType.where(scope: @params[:request_type]).first
    # @params[:request_type] = @request_type

    @params
  end
end
