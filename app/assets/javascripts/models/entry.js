Ets.Models.entries = Backbone.Model.extend({
    parse: function (response) {
        var splits = response.splits;

        response.start_time = (response.chip_start === "0") ? response.gun_start : reponse.chip_start;
        response.time = (response.finish_time.toMsec() - response.start_time.toMsec()).toRaceTime();
        if (response.time === 'NaN:NaN:NaN.NaN') response.time = 'Did not Finish';
        response.splits = new Ets.Collections.splits(splits);
        response.splits.each(function (split) {
            response[split.get('label')] = split.get('length');
        });
        return response;
    },
    urlRoot: '/entries/',
});
