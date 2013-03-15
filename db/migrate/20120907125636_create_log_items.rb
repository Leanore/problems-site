class CreateLogItems < ActiveRecord::Migration
  def change
    create_table :log_items do |t|
      t.integer :user_id
      t.string :content
      t.integer :problem_id
      t.datetime :at

      t.timestamps
    end
  end
end
