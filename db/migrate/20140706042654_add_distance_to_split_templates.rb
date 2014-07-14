class AddDistanceToSplitTemplates < ActiveRecord::Migration
  def change
      add_column :split_templates, :distance, :float
  end
end
