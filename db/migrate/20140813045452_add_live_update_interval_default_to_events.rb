class AddLiveUpdateIntervalDefaultToEvents < ActiveRecord::Migration
  def change
      change_column :events, :live_update_interval, :integer, default: 60
  end
end
