Ets.Views.home = Ets.Views.base.extend({
    render: function () {
        this.$el.html(this.template());
    },
    template: JST['static/home']
});
