class UserFeedbacksController < ApplicationController
  # before_action :authenticate_user!

  def all
    @feedbacks = UserFeedback.where(user: current_user)
    p "* " * 100
    p @feedbacks
    render json: @feedbacks
  end

  def create
    p "* " * 200
    @feedback = UserFeedback.new(feedback_params)
    @feedback.user = current_user

    @feedback.save!

    target_issue = @feedback.issue
    if target_issue.user_feedbacks.count > 15
      # Get mode of request_type classification made by users
      request_type_inputs = target_issue.user_feedbacks.pluck(:request_type_id).sort
      freq = request_type_inputs.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
      request_type_id_users = request_type_inputs.max_by { |v| freq[v] }
      # Set mode as the issue.request_type.id, overwriting classifcation prediction made by Watson. By default, will take the first integer if there are multiple modes.
      target_issue.request_type_id = request_type_id_users
      target_issue.save!
    end

    render json: ['hii']
  end



  private
  def feedback_params
    @params = params.require(:feedback).permit(:validity, :difficulty, :request_type, :issue_id)
    @request_type = RequestType.find_by(scope: @params[:request_type])
    @params[:request_type] = @request_type

    @params
  end
end
