class CreateUserFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_feedbacks do |t|

      t.integer :validity
      t.integer :diffculty
      t.integer :scope
      t.integer :user_id

      t.timestamps
    end
  end
end