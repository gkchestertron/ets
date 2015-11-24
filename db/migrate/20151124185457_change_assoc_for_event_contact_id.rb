class ChangeAssocForEventContactId < ActiveRecord::Migration
  def change
    rename_column :assoc_contact_event, :contact_id, :event_contact_id
  end
end
