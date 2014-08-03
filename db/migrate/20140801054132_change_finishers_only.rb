class ChangeFinishersOnly < ActiveRecord::Migration
  def change
      change_column :events, :finishers_only, :integer
  end
end
