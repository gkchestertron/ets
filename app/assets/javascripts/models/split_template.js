Ets.Models.split_templates = Backbone.Model.extend({
    parse: function (response) {
        this.id = response.id;
        Ets.split_templates.add(this);
        return response;
    },
    urlRoot: '/split_templates/'
});
