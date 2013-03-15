class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.date :posted_date
      t.integer :solved_times

      t.timestamps
    end
  end
end
