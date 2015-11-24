class AssocContactEvent < ActiveRecord::Base
  belongs_to :event_contact
  belongs_to :event
end
