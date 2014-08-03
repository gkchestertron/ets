class AddFinishersOnly < ActiveRecord::Migration
  def change
      add_column :events, :finishers_only, :string
  end
end
