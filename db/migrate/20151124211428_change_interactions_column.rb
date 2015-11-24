class ChangeInteractionsColumn < ActiveRecord::Migration
  def change
    rename_column :interactions, :nees_contact, :needs_contact
  end
end
