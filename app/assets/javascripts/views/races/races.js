Ets.Views.races = {};

Ets.Views.races.show = Ets.Views.base.extend({
    initialize: function () {
        this.model.get('entries').getRanks('overall_rank');
        this.model.generateGroups();
        this.super();
        window.view = this;
    },
    events: {
        'click th': 'sort'
    },
    toggleView: function (event) {
        var $button = $(event.currentTarget);
            
        if ($button.html() === 'Show Age Groups') {
            this.drawGroups();
            $button.html('Show All');
        } else {
            this.render();
            $button.html('Show Age Groups');
        }
    },
    sort: function (event) {
        var $th        = $(event.currentTarget),
            comparator = $th.data('comparator'),
            entries    = this.model.get('entries'),
            prevComp   = entries.comparator,
            $arrows,
            arrow;

        entries.comparator = comparator || 'time';
        if (prevComp === comparator) {
            entries.models.reverse();
            arrow = '.glyphicon-arrow-down';
        } else {
            entries.sort();
            arrow = '.glyphicon-arrow-up';
        }
        this.render();
        $('th span').show();
        $arrows = $('th[data-comparator="' + comparator + '"] div.sort-arrows'),
        $arrows.find(arrow).hide();
    },
    render: function () {
        this.$el.html(this.template({ race: this.model, entries: this.model.get('entries') }));
    },
    drawGroups: function () {
        var parentView = this,
            $tables = this.$('#race-tables'),
            groups = this.model.get('groups');

        $tables.html('');
        groups.comparator = 'bottom_age';
        groups.sort();
        groups.each(function (group) {
            if (group.get('entries').length) {
                var childView = new Ets.Views.groups.show({
                        race: parentView.model,
                        model: group
                    });

                $tables.append(childView.$el);
                childView.render();
            }
        });
    },
    template: JST['races/show']
});

Ets.Views.groups = {};

Ets.Views.groups.show = Ets.Views.races.show.extend({
    initialize: function (options) {
        this.race = options.race;
    },
    template: JST['groups/show'],
    render: function () {
        this.$el.html(this.template({
            group: this.model,
            race: this.race,
            entries: this.model.get('entries')
        }));
    }
});
