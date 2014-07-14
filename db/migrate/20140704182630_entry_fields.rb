class EntryFields < ActiveRecord::Migration
    def change
        drop_table :entries

        create_table :entries do |t|
            t.integer :bib_number
            t.string :first_name
            t.string :last_name
            t.string :gun_start
            t.string :chip_start
            t.string :split_1
            t.string :split_2
            t.string :split_3
            t.string :split_4
            t.string :split_5
            t.string :split_6
            t.string :split_7
            t.string :split_8
            t.string :split_9
            t.string :split_10
            t.string :finish_time
            t.string :adjustment_time
            t.string :gun_elapsed_time
            t.string :chip_elapsed_time
            t.integer :age
            t.string :division
            t.string :gender
            t.string :city
            t.string :state
            t.string :team_name
            t.integer :team_order
            t.string :sms_phone
            t.string :email
            t.integer :chip_number
            t.string :user_field_1
            t.string :user_field_2
            t.string :user_field_3
            t.integer :unique_id
            t.string :photo_files
        end
        add_index :entries, :first_name
        add_index :entries, :last_name
        add_index :entries, :age
        add_index :entries, :division
        add_index :entries, :gender
        add_index :entries, :city
        add_index :entries, :state
        add_index :entries, :team_name
        add_index :entries, :sms_phone
        add_index :entries, :email
        add_index :entries, :chip_number
        add_index :entries, :unique_id
    end
end
