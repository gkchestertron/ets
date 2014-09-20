Ets.Models.entries = Backbone.Model.extend({
    initialize: function (options) {
        var race = options.race || this.collection.race,
            start        = this.collection.start_field || 'chip_start',
            backup_start = (start === 'chip_start') ? 'gun_start' : 'chip_start',
            start_time   = (this.get(start) === '0') ? this.get(backup_start) : this.get(start),
            time         = (this.get('finish_time').toMsec() - start_time.toMsec()).toRaceTime();

        if (time === 'NaN:NaN:NaN.NaN') time = 'N/A';
        this.set({
            race       : race,
            start_time : start_time,
            time       : time
        });
    },
    parse: function (response) {
        var splits = response.splits;

        response.start_time = (response.chip_start === "0") ? response.gun_start : response.chip_start;
        response.time = (response.finish_time.toMsec() - response.start_time.toMsec()).toRaceTime();
        if (response.time === 'NaN:NaN:NaN.NaN') response.time = 'N/A';
        response.splits = new Ets.Collections.splits(splits, { parse: true });
        response.splits.each(function (split) {
            response[split.get('label')] = split.get('length');
        });
        this.id = response.id;
        Ets.entries.add(this);
        return response;
    },
    urlRoot: '/entries/'
});
