class ChangeBibTypeAgain < ActiveRecord::Migration
  def change
      remove_column :entries. :bib_number
      add_column :entries, :bib_number, :integer
  end
end
