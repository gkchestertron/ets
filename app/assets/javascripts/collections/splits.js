Ets.Collections.splits = Backbone.Collection.extend({
    comparator: 'order',
    initialize: function () {
        this.listenTo(this, 'sync add change', this.sort);
    },
    model: Ets.Models.splits
});
