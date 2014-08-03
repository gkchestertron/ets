class ChangeBibType < ActiveRecord::Migration
  def change
      change_column :entries, :bib_number, :string
  end
end
