class AddColumnToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :request_type_id, :integer
  end
end
