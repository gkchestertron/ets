Ets.Models.Entry = Backbone.Model.extend({
    parse: function (response) {
        var splits = response.splits;

        response.splits = new Ets.Collections.Splits(splits);
        return response;
    },
    urlRoot: '/entries/',
});
