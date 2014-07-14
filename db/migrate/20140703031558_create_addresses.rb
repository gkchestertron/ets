class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.integer :user_id
      t.string :city
      t.string :state
      t.integer :zip

      t.timestamps
    end
      add_index :addresses, :address
      add_index :addresses, :city
      add_index :addresses, :state
      add_index :addresses, :zip
      add_index :addresses, :user_id
  end
end
