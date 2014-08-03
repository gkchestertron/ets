Ets.Models.group_defaults = Backbone.Model.extend({
    urlRoot: '/group_defaults/',
    parse: function (response) {
        this.id = response.id;
        Ets.group_defaults.add(this);
        return response;
    }
});
