class AddUserFieldsAndSplitTypesToRace < ActiveRecord::Migration
    def change
        add_column :entries, :user_field_1_label, :string
        add_column :entries, :user_field_2_label, :string
        add_column :entries, :user_field_3_label, :string
        add_column :entries, :split_1_label, :string
        add_column :entries, :split_2_label, :string
        add_column :entries, :split_3_label, :string
        add_column :entries, :split_4_label, :string
        add_column :entries, :split_5_label, :string
        add_column :entries, :split_6_label, :string
        add_column :entries, :split_7_label, :string
        add_column :entries, :split_8_label, :string
        add_column :entries, :split_9_label, :string
        add_column :entries, :split_10_label, :string
    end
end
