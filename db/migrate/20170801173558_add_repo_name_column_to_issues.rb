class AddRepoNameColumnToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :repo_name, :string
  end
end
