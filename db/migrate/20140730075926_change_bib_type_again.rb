class ChangeBibTypeAgain < ActiveRecord::Migration
  def change
      change_column :entries, :bib_number, :integer
  end
end
