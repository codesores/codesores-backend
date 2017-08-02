class AddStarCountToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :stars_count, :integer, default: 0
  end
end
