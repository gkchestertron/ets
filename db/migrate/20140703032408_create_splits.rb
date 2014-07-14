class CreateSplits < ActiveRecord::Migration
  def change
    create_table :splits do |t|
      t.string :time
      t.string :type
      t.integer :entry_id

      t.timestamps
    end
    add_index :splits, :entry_id
  end
end
