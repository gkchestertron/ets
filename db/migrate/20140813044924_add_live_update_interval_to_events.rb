class AddLiveUpdateIntervalToEvents < ActiveRecord::Migration
  def change
      add_column :events, :live_update_interval, :integer
  end
end
