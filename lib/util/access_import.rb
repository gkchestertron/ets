# module for one-time import from ms access csv
# note: don't let Tim do anymore microsoft
# also be less insulting about it next time
module AccessImport
  def import_access_csv(path)
    csv = CSV.read(path, headers: true)
    # break into event data, contact data and associations
    csv.each do |row|
      # populate event with known fields
      event = Event.new(
        name: row.name,
        date_time: row.date,
        website: row.website,
        location: row.location,
        street: row.street,
        city: row.city,
        state: row.state,
        zip: row.zip,
        number_of_participants: row.number_of_participants,
        online_registration_link: row.online_registration_link,
        notes: row.notes,
        results_url: row.results_url,
        course_map_url: row.course_map_url,
      )

      # if it has an event type, find it or create it and then set its id on the event
      if row.event_type_id
        event_type = EventType.find_by_name(row.event_type_id)
        event_type ||= EventType.create(row.event_type_id)
        event.event_type_id = event_type.id
      end

      # if it has a contact_id find or create that contact and update event with its id
      # many to many assoc
      if row.contact_email
        contact = Contact.find_by_email(row.contact_email)
        contact ||= Contact.create(
          email: row.contact_email, 
          first_name: row.ContactFirstName,
          last_name: row.ContactLastName,
          phone: row.phone
        )
      end

      # if it has a CompanyName build contact and make it the billing_contact_id for event
      if row.CompanyName
        billing_contact = Contact.find_by_company_name(row.CompanyName)
        billing_contact ||= Contact.create(
          company_name: row.CompanyName,
          street: row.BillingAddress,
          city: row.BillingCity,
          state: row.BillingState,
          zip: row.BillingZip,
        )
        event.billing_contact_id = billing_contact.id
      end

      event.save

      # make event => contact assoc
      if contact
        AssocContactEvent.create(event_id: event.id, contact_id: contact.id)
      end
    end
  end
end
