class CleanUp < ActiveRecord::Migration
  def change
      drop_table :addresses
      remove_column :entries, :user_field_1_label
      remove_column :entries, :user_field_2_label
      remove_column :entries, :user_field_3_label
      remove_column :entries, :split_1_label
      remove_column :entries, :split_2_label
      remove_column :entries, :split_3_label
      remove_column :entries, :split_4_label
      remove_column :entries, :split_5_label
      remove_column :entries, :split_6_label
      remove_column :entries, :split_7_label
      remove_column :entries, :split_8_label
      remove_column :entries, :split_9_label
      remove_column :entries, :split_10_label
      drop_table :photos
      remove_column :races, :name
      remove_column :races, :date
      remove_column :races, :location
      remove_column :races, :description
      remove_column :races, :import_path
      add_column :races, :division, :string
  end
end
