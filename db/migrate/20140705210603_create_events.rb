class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :location
      t.string :date_time
      t.text :description
      t.string :import_path
      t.string :user_field_1_label
      t.string :user_field_2_label
      t.string :user_field_3_label

      t.timestamps
    end
    add_index :events, :name
    add_index :events, :date_time
    add_index :events, :location
  end
end
