class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :fullname
      t.string :gender
      t.date :birth_date
      t.string :location
      t.text :shortbio
      t.string :avatar

      t.timestamps
    end
  end
end
