class AddColumn < ActiveRecord::Migration
  def change
    add_column :profiles, :theme, :string, :null => false, :default => "dark"
  end
end
