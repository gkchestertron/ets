class AddIndexToIsVisibleOnEvents < ActiveRecord::Migration
  def change
    add_index :events, :is_visible
  end
end
