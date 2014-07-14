class AddImportPathToRace < ActiveRecord::Migration
  def change
      add_column :races, :import_path, :string
  end
end
