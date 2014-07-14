Ets.Views.races = Backbone.View.extend({
    initialize: function () {
        this.collection = Ets.races;
    },
    render: function () {
        this.$el.html(this.template({ races: this.collection }));
    },
    template: JST['races/index']
});
