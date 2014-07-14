class AddSplitsAgain < ActiveRecord::Migration
  def change
      create_table :splits do |t|
          t.integer :entry_id
          t.string  :time
          t.string  :length
          t.timestamps
      end
  end
end
