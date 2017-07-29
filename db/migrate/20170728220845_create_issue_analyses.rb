class CreateIssueAnalyses < ActiveRecord::Migration[5.1]
  def change
    create_table :issue_analyses do |t|

      t.integer :validity_indicator
      t.integer :complexity_indicator
      t.integer :scope_indicator
      t.integer :request_type_id

      t.timestamps
    end
  end
end
