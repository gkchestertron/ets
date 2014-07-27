Ets.Collections.split_templates = Backbone.Collection.extend({
    initialize: function () {
        this.listenTo(this, 'sync add change', this.sort);
    },
    comparator: 'order',
    model: Ets.Models.split_templates,
    url: '/split_templates/'
});
