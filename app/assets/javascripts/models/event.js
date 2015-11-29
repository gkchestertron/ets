Ets.Models.events = Backbone.Model.extend({
    parse: function (response) {
        var races          = response.races,
            event_contacts = response.event_contacts,
            assoc_contact_events = response.assoc_contact_events,
            interactions = response.interactions;

        response.races = new Ets.Collections.races(races, { parse: true });
        response.event_contacts = new Ets.Collections.EventContacts(event_contacts, { parse: true });
        response.assoc_contact_events = new Ets.Collections.AssocContactEvents(assoc_contact_events, { parse: true });
        response.interactions = new Ets.Collections.Interactions(interactions, { parse: true });
        if (!response.id) return false;
        this.id = response.id;
        this.set('id', response.id);
        Ets.events.add(this);
        return response;
    },

    urlRoot: '/events/'
});
