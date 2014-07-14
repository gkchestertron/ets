class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :phone_number
      t.string :overall_time
      t.string :email
      t.integer :user_id
      t.integer :race_id
      t.integer :rank
      t.string :age_group
      t.integer :age_group_rank
      t.string :gender

      t.timestamps
    end
      add_index :entries, :first_name
      add_index :entries, :last_name
      add_index :entries, :address
      add_index :entries, :city
      add_index :entries, :state
      add_index :entries, :zip
      add_index :entries, :phone_number
      add_index :entries, :overall_time
      add_index :entries, :email
      add_index :entries, :user_id
      add_index :entries, :race_id
      add_index :entries, :rank
      add_index :entries, :age_group
      add_index :entries, :age_group_rank
  end
end
