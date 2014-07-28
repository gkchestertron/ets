class AddPlaceOd < ActiveRecord::Migration
  def change
      add_column :events, :place_id, :string
      add_index :events, :place_id
  end
end
