class AddColumnValue < ActiveRecord::Migration
  def change
    add_column :solved_problems, :given_answer, :string
  end
end
