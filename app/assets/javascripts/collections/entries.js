Ets.Collections.entries = Backbone.Collection.extend({
    getRanks: function (rankAttr) {
        var self   = this,
            defaultAttr,
            models = [],
            race_defaults = this.race.get('group_defaults'),
            defaults = { 
                'M': race_defaults.findWhere({ gender: 'M' }),
                'F': race_defaults.findWhere({ gender: 'F' })
            },
            top_finishers = { 'M': [], 'F': [] },
            i = 1,
            m = 1,
            f = 1;
            
        this.comparator = 'time';
        this.sort();
    
        if (rankAttr === 'overall_rank') {
            this.each(function (model) {
                model.ranks = model.ranks || {};
                if (model.get('finish_time') != 0) {
                    model.ranks['overall_rank'] = i;
                    model.set('overall_rank', i);
                    if (model.get('gender') === 'M') {
                        model.set('gender_rank', m);
                        m++;
                    } else {
                        model.set('gender_rank', f);
                        f++;
                    }
                    i++;
                } else {
                    models.push(model);
                }
            });
        } else {
            _.each(['M', 'F'], function (gender) {
                var top_exclusions = defaults[gender].get('top_exclusions');

                _.each(self.where({ gender: gender }), function (model) {
                    model.ranks = model.ranks || {};
                    if (model.get('finish_time') != 0) {
                        model.ranks[rankAttr] = i;
                        defaultAttr = 'age_rank';
                        if (top_exclusions >= model.get('gender_rank')) {
                            top_finishers[gender].push(model);
                            self.remove(model);
                            return;
                        } else {
                            model.set(defaultAttr, i);
                            i++;
                        }
                    } else {
                        models.push(model);
                    }
                });
            });
        }
        
        this.race.get('groups').add([
            { bottom_age: 0, description: 'Top Male Overall', gender: 'M', entries: new Ets.Collections.entries(top_finishers['M']) },
            { bottom_age: 0, description: 'Top Female Overall', gender: 'F', entries: new Ets.Collections.entries(top_finishers['F']) }
        ]);
        if (this.race && this.race.get('event').get('finishers_only')) {
            self.remove(models); //for removing non-finishers
        }
    },
    model: Ets.Models.entries,
    url: '/entries/'
});
