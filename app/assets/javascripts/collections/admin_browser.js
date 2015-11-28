Ets.Collections.AdminBrowser = Backbone.Collection.extend({
    initialize: function (path) {
        path = '/' + path + '/';
        this.url = path;
        this.model.prototype.urlRoot = path;
    },

    model: Ets.Models.AdminBrowser
});
