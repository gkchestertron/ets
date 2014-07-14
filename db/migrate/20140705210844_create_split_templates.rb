class CreateSplitTemplates < ActiveRecord::Migration
  def change
    create_table :split_templates do |t|
      t.string :label
      t.string :diff_field_1
      t.string :diff_field_2
      t.integer :order
      t.integer :race_id

      t.timestamps
    end
  end
end
