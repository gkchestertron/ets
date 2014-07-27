Ets.Models.splits = Backbone.Model.extend({
    parse: function (response) {
        this.id = response.id;
        Ets.splits.add(this);
        return response;
    }
});
