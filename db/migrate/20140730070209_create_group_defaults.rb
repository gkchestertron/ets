class CreateGroupDefaults < ActiveRecord::Migration
  def change
    create_table :group_defaults do |t|
      t.string :gender
      t.integer :top_exclusions
      t.integer :masters_age_start
      t.integer :masters_inclusions
      t.integer :grand_masters_age_start
      t.integer :grand_masters_inclusions
      t.integer :senior_masters_age_start
      t.integer :senior_masters_inclusions
      t.integer :race_id

      t.timestamps
    end
    add_index :group_defaults, :race_id
  end
end
