class ChangeContactTableName < ActiveRecord::Migration
  def change
    rename_table :contacts, :event_contacts
  end
end
