class Contact < ActiveRecord::Base
  has_many :assoc_contact_events
  has_many :events, through: :assoc_contact_events
  has_many :billed_events, class_name: "Event", foreign_key: "billing_contact_id"
end
