Ets.Models.events = Backbone.Model.extend({
    parse: function (response) {
        var races = response.races;
            
        this.set('races', new Ets.Collections.races(races));
        delete response.races;
        return response;
    },
    urlRoot: '/events/'
});
