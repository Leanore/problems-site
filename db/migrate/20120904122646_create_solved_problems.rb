class CreateSolvedProblems < ActiveRecord::Migration
  def change
    create_table :solved_problems do |t|
      t.integer :user_id
      t.integer :problem_id
      t.datetime :solved_at

      t.timestamps
    end
  end
end
