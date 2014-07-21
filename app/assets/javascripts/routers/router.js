Ets.Routers.mainRouter = Backbone.Router.extend({
    initialize: function () {
        this.$rootEl = $('#app');
    },
    routes: {
        ''                   : 'home',
        ':baseRoute'         : 'index',
        ':baseRoute/new'     : 'new',
        ':baseRoute/:id'     : 'show',
        ':baseRoute/:id/edit': 'edit'
    },
    home: function () {
        console.log('home');
    },
    edit: function (baseRoute, id) {
        var self  = this,
            model = new Ets.Models[baseRoute]({ id: id }),
            view;

        model.fetch({
            success: function () {
                view = new Ets.Views[baseRoute].edit({ model: model });
                self._swapView(view);
            }
        });
    },
    index: function (baseRoute) {
        var self = this,
            view,
            collection = new Ets.Collections[baseRoute];

        collection.fetch({
            success: function () {
                view = new Ets.Views[baseRoute].index({ collection: collection });
                self._swapView(view);
            }
        });
    },
    new: function (baseRoute) {
        var model = new Ets.Models.events,
            view  = new Ets.Views[baseRoute].new({ model: model });

        this._swapView(view);
    },
    show: function (baseRoute, id) {
        var self  = this,
            model = new Ets.Models[baseRoute]({ id: id }),
            view;

        model.fetch({
            success: function () {
                view = new Ets.Views[baseRoute].show({ model: model });
                self._swapView(view);
window.test = model;
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
