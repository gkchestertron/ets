class AddSplitFields < ActiveRecord::Migration
  def change
      add_column :races, :event_id, :integer
      add_column :splits, :label, :string
      add_column :splits, :order, :integer
      add_index :races, :event_id
  end
end
