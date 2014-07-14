Ets.Views.entries = {};

Ets.Views.entries.index = Backbone.View.extend({
    template: JST['entries/index']
});

Ets.Views.entries.new = Backbone.View.extend({
    template: JST['entries/new']
});

Ets.Views.entries.show = Backbone.View.extend({
    template: JST['entries/show']
});
