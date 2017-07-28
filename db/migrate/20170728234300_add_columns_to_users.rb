class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :avatar_url, :string
    add_column :users, :html_url, :string
    add_column :users, :user_created_at, :datetime
    add_column :users, :public_repos, :integer
  end
end
