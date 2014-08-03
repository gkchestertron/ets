class AddStartEndTimes < ActiveRecord::Migration
  def change
      add_column :events, :start_time, :string
      add_column :events, :end_time, :string
      add_index :events, :start_time
      add_index :events, :end_time
  end
end
