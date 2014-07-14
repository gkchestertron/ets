Ets.Models.Race = Backbone.Model.extend({
    urlRoot: '/races/',
    parse: function (response) {
        var entries = response.entries;

        response.entries = new Ets.Collections.Entries(entries, { parse: true });
        return response;
    },
});
