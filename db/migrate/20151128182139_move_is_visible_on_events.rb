class MoveIsVisibleOnEvents < ActiveRecord::Migration
  def change
    change_column :events, :is_visible, :boolean, after: :id
  end
end
