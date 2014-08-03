Ets.Models.groups = Backbone.Model.extend({
    urlRoot: '/groups/',
    parse: function (response) {
        this.id = response.id;
        Ets.groups.add(this);
        return response;
    }
});
