class AddDistanceToSplits < ActiveRecord::Migration
  def change
      add_column :splits, :distance, :float
  end
end
