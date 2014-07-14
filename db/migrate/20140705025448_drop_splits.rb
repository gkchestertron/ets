class DropSplits < ActiveRecord::Migration
  def change
      drop_table :splits
  end
end
