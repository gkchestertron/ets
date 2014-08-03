class AddsGroupFields < ActiveRecord::Migration
  def change
      remove_column :groups, :age_range
      remove_column :groups, :exclusions
      add_column :groups, :description, :string
      add_column :groups, :bottom_age, :string
      add_column :groups, :top_age, :string
  end
end
