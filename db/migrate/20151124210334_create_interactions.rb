class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.integer :event_id
      t.text :note
      t.timestamps
      t.boolean :nees_contact
    end
  end
end
