Ets.Collections.EventContacts = Backbone.Collection.extend({
    comparator: function (model) {
        return model.fullname();
    },

    model: Ets.Models.EventContact,

    url: '/event_contacts/'
});
