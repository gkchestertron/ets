Ets.Views.races = {};

Ets.Views.races.show = Backbone.View.extend({
    initialize: function () {
        this.model.get('entries').getOverallRanks();
    },
    events: {
        'click th': 'sort',
    },
    sort: function (event) {
        var $th        = $(event.currentTarget),
            comparator = $th.data('comparator'),
            entries    = this.model.get('entries'),
            prevComp   = entries.comparator;

        entries.comparator = comparator || 'time';
        if (prevComp === comparator) {
            entries.models.reverse();
        } else {
            entries.sort();
        }
        this.render();
    },
    render: function () {
        this.$el.html(this.template({ race: this.model }));
    },
    template: JST['races/show']
});
