class CreateUserFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_feedbacks do |t|

      t.integer :validity
      t.integer :difficulty
      t.integer :request_type_id
      t.integer :user_id

      t.timestamps
    end
  end
end
