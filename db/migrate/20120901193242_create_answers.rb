class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :problem_id
      t.string :answer, :null => false
      t.timestamps
    end
  end
end
