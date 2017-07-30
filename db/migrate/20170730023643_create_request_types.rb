class CreateRequestTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :request_types do |t|
      t.string :scope

      t.timestamps
    end
  end
end
