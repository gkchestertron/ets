Ets.Collections.events = Backbone.Collection.extend({
    model: Ets.Models.events,

    // this will break .create() on this collection 
    // so don't use that or do something more clever here
    url: '/events/?is_visible=true'
});
