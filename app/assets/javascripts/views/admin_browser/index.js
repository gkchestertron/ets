Ets.Views.AdminBrowser = Ets.Views.AdminBrowser || {};

Ets.Views.AdminBrowser.Index = Backbone.View.extend({
    render: function () {
        var vars =  { model: this.model, collection: this.collection };
        this.$el.html(this.template(vars));
    },

    template: JST['admin_browser/index']
});
