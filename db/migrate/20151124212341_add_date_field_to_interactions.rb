class AddDateFieldToInteractions < ActiveRecord::Migration
  def change
    add_column :interactions, :date, :date
  end
end
