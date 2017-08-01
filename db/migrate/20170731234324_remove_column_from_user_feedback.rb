class RemoveColumnFromUserFeedback < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_feedbacks, :request_type_id
  end
end
