Ets.Models.races = Backbone.Model.extend({
    urlRoot: '/races/',
    parse: function (response) {
        var race            = this,
            entries         = response.entries,
            event           = response.event,
            split_templates = response.split_templates,
            groups          = response.groups,
            group_defaults  = response.group_defaults;

        response.entries = new Ets.Collections.entries();
        response.entries.start_field = response.start_field;
        response.entries.add(entries, { parse: true });

        response.event   = new Ets.Models.events(event, { parse: true });
        response.groups  = new Ets.Collections.groups(groups, { parse: true });
        response.group_defaults = new Ets.Collections.group_defaults(group_defaults, { parse: true });
        response.split_templates = new Ets.Collections.split_templates(split_templates, { parse: true });

        this.id = response.id;
        Ets.races.add(this);
        response.entries.race = this;
        return response;
    },
    generateGroups: function () {
        var race = this,
            entries;

        this.get('groups').each(function (group) {
            var bottom_age = group.get('bottom_age'),
                top_age    = group.get('top_age');

            entries = race.get('entries').filter(function (entry) {
                var age = entry.get('age');
                return (bottom_age <= age && age <= top_age && 
                        entry.get('gender') === group.get('gender'));   
            });

            group.set('entries', new Ets.Collections.entries(entries));
            group.get('entries').race = race;
            group.get('entries').getRanks(group.get('description'));
        });
    }
});
