Ets.Models.races = Backbone.Model.extend({
    urlRoot: '/races/',
    parse: function (response) {
        var entries         = response.entries,
            event           = response.event,
            split_templates = response.split_templates;

        response.entries = new Ets.Collections.entries(entries, { parse: true });
        response.event   = new Ets.Models.events(event, { parse: true });
        response.split_templates = new Ets.Collections.split_templates(split_templates, { parse: true });
        return response;
    },
});
