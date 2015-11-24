class ChangeAssocTableName < ActiveRecord::Migration
  def change
    rename_table :assoc_contact_event, :assoc_contact_events
  end
end
