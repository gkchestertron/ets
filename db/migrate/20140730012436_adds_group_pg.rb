class AddsGroupPg < ActiveRecord::Migration
  def change
      add_column :races, :group_page, :string
  end
end
