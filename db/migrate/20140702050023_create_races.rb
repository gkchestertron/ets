class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :name
      t.date :date
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end
