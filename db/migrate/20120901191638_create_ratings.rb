class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :problems_solved
      t.integer :problems_posted

      t.timestamps
    end
  end
end
