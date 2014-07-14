class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :entry_id
      t.string :path
      t.string :tags
      t.string :location
      t.integer :author_id

      t.timestamps
    end
    add_index :photos, :entry_id
    add_index :photos, :author_id
  end
end
