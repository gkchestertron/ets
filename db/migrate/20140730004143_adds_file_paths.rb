class AddsFilePaths < ActiveRecord::Migration
  def change
      add_column :events, :database_file_path, :string
      add_column :events, :division_file_path, :string
      add_column :events, :group_file_path, :string
  end
end
