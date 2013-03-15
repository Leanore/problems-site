class SetDefaults < ActiveRecord::Migration
  def up
    change_column_default(:ratings, :problems_solved, 0)
    change_column_default(:ratings, :problems_posted, 0)
    change_column_default(:problems, :solved_times, 0)
    change_column_default(:problems, :posted_date, Date.today)
    change_column :problems, :title, :string, :null => false, :default => ""
    change_column :problems, :description, :text, :null => false, :default => ""
  end

  def down
  end
end
