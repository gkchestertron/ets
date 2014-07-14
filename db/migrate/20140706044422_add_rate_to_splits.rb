class AddRateToSplits < ActiveRecord::Migration
  def change
      add_column :splits, :rate, :float
  end
end
