class AddStartFieldToRaces < ActiveRecord::Migration
  def change
      add_column :races, :start_field, :string
  end
end
