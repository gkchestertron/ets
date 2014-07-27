Ets.Routers.mainRouter = Backbone.Router.extend({
    initialize: function () {
        this.$rootEl = $('#app');
    },
    routes: {
        ''                   : 'index',
        ':baseRoute'         : 'index',
        ':baseRoute/new'     : 'new',
        ':baseRoute/:id'     : 'show',
        ':baseRoute/:id/edit': 'edit'
    },
    edit: function (baseRoute, id) {
        var self  = this,
            model = new Ets.Models[baseRoute]({ id: id }),
            view;

        model.fetch({
            success: function (model) {
                view = new Ets.Views[baseRoute].edit({ model: model });
                self._swapView(view);
            }
        });
    },
    index: function (baseRoute, id) {
        var self = this,
            view,
            collection; 
            
        if (Ets.Collections[baseRoute]) collection = new Ets.Collections[baseRoute];
        if (collection) {
            collection.fetch({
                success: function (collection) {
                    if (!id) id = 'index';
                    view = new Ets.Views[baseRoute][id]({ collection: collection });
                    self._swapView(view);
                }
            });
        } else {
            view = new Ets.Views[baseRoute];
            self._swapView(view);
        }
    },
    new: function (baseRoute) {
        var model = new Ets.Models.events,
            view  = new Ets.Views[baseRoute].new({ model: model });

        this._swapView(view);
    },
    search: function (baseRoute, name) {
        //get a collection based on the name
    },
    show: function (baseRoute, id) {
        if (isNaN(parseInt(id))) {
            if (Ets.Views[baseRoute][id]) {
                this.index(baseRoute, id);
                return false;
            } else {
                this.search(baseRoute, id);
                return false;
            }
        }

        var self  = this,
            model = new Ets.Models[baseRoute]({ id: id }),
            view;

        model.fetch({
            success: function (model) {
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
