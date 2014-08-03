Ets.Models.events = Backbone.Model.extend({
    parse: function (response) {
        var races = response.races;
            
        response.races = new Ets.Collections.races(races, { parse: true });
        if (!response.id) return false;
        this.id = response.id;
        this.set('id', response.id);
        Ets.events.add(this);
        return response;
    },
    urlRoot: '/events/'
});
