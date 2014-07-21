Ets.Collections.entries = Backbone.Collection.extend({
    getAgeRanks: function () {
        console.log('getting age ranks');
    },
    getOverallRanks: function () {
        var self   = this,
            models = [];

        this.comparator = 'time';
        this.sort();
        this.each(function (model, i) {
            if (model.get('finish_time') != 0) {
                model.set('overall_rank', i + 1);
            } else {
                models.push(model);
            }
        });
        self.remove(models);
    },
    model: Ets.Models.entries,
    url: '/entries/'
});
