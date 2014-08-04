class ChangeFinishersOnly < ActiveRecord::Migration
  def change
      remove_column :events, :finishers_only
      add_column :events, :finishers_only, :integer
  end
end
