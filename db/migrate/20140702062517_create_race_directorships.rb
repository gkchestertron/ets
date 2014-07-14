class CreateRaceDirectorships < ActiveRecord::Migration
  def change
    create_table :race_directorships do |t|
      t.integer :user_id
      t.integer :race_id

      t.timestamps
    end
  end
end
