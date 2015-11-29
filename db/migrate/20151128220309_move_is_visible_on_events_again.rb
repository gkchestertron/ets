class MoveIsVisibleOnEventsAgain < ActiveRecord::Migration
  def change
    change_column :events, :is_visible, :boolean, after: :name
  end
end
