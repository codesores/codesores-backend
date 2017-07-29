class CreateRepos < ActiveRecord::Migration[5.1]
  def change
    create_table :repos do |t|

      t.string :name
      t.string :owner
      t.string :language
      t.string :description
      t.integer :stargazers_count
      t.integer :issues_count
      t.integer :pull_request_count
      t.string :url
      t.integer :forks_count
      t.datetime :repo_updated_at
      t.integer :contributors_count
      t.integer :mentionable_user_count

      t.timestamps
    end
  end
end
