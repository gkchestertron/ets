Ets.Routers.mainRouter = Backbone.Router.extend({
    initialize: function () {
        this.$rootEl = $('#app');
    },
    routes: {
        ':baseRoute'         : 'index',
        ':baseRoute/new'     : 'new',
        ':baseRoute/:id'     : 'show',
        ':baseRoute/:id/edit': 'edit'
    },
    edit: function (baseRoute, id) {
        var self  = this,
            model = Ets[baseRoute].get(id),
            view;

        model.fetch({
            success: function () {
                views = new Ets.Views[baseRoute].edit({ model: model });
                self._swapView(view);
            }
        });
    },
    index: function (baseRoute) {
        var view = new Ets.Views[baseRoute].index; // name views lower case

        this._swapView(view);
    },
    new: function (baseRoute) {
        var view = new Ets.Views[baseRoute].new;

        this._swapView(view);
    },
    show: function (baseRoute, id) {
        var self  = this,
            model = Ets[baseRoute].get(id),
            view;

        model.fetch({
            success: function () {
                view = new Ets.Views[baseRoute].show({ model: model });
                self._swapView(view);
            }
        });
    },
    _swapView: function (view) {
        this.currentView && this.currentView.remove();
        this.currentView = view;
        this.$rootEl.html(view.$el);
        view.render();
    }
});
