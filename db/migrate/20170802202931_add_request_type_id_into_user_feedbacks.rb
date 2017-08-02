class AddRequestTypeIdIntoUserFeedbacks < ActiveRecord::Migration[5.1]
  def change
    add_column :user_feedbacks, :request_type_id, :integer
  end
end
