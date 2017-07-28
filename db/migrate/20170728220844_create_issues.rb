class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|

      t.string :title
      t.string :labels
      t.datetime :issue_create_at
      t.integer :comment_count
      t.string :url
      t.string :author
      t.integer :particpant_count
      t.integer :assignee_count
      t.integer :repo_id

      t.timestamps
    end
  end
end
