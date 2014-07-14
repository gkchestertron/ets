class AddUserAndRaceIdsToEntries < ActiveRecord::Migration
  def change
      add_column :entries, :user_id, :integer
      add_column :entries, :race_id, :integer
      add_index :entries, :user_id
      add_index :entries, :race_id
  end
end
