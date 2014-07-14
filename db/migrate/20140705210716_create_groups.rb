class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :age_range
      t.string :gender
      t.string :exclusions
      t.integer :race_id

      t.timestamps
    end
    add_index :groups, :race_id
  end
end
