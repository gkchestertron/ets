Ets.Views.events = {};

Ets.Views.events.index = Ets.Views.base.extend({
    initialize: function () {
        this.listenTo(this.collection, 'add remove sync', this.render);
        this.super();
    },
    deleteEvent: function (event) {
        var event = this.collection.get($(event.currentTarget).data('model-id'));

        event.destroy();
    },
    render: function () {
        this.$el.html(this.template({ events: this.collection }));
    },
    template: JST['events/index']
});

Ets.Views.events.calendar = Ets.Views.events.index.extend({
    initialize: function () {
        this.generateCalendarEvents();
    },
    generateCalendarEvents: function () {
        var view = this;

        this.calendarEvents = [];
        this.collection.each(function (event) {
            view.calendarEvents.push({
                title: event.get('name'),
                start: event.get('date_time')
            });
        });
    },
    render: function () {
        var view = this;

        this.$el.html(this.template({ events: this.collection }));
        $('#events-calendar').fullCalendar({
            events: view.calendarEvents
        });
    },
    template: JST['events/calendar']
});

Ets.Views.events.results  = Ets.Views.events.index.extend({
    initialize: function () {
        this.listenTo(this.collection, 'add remove sync', this.render);
        this.collection.comparator = 'date_time';
        this.collection.sort();
        this.super();
    }
});

Ets.Views.events.upcoming = Ets.Views.events.index.extend({
    initialize: function () {
        this.listenTo(this.collection, 'add remove sync', this.render);
        this.collection.comparator = 'date_time';
        this.collection.sort();
        this.collection.models.reverse();
        this.super();
    }
});

Ets.Views.events.show = Ets.Views.base.extend({
    initialize: function () {
        window.view = this;
        this.super();
    },
    render: function () {
        this.$el.html(this.template({ event: this.model }));
    },
    template: JST['events/show']
});

Ets.Views.events.new = Ets.Views.base.extend({
    initialize: function () {
        var view = this;

        if (!this.model.id) {
            this.listenToOnce(this.model, 'sync', function () {
                Ets.router.navigate('events/' + view.model.id + '/edit', { trigger: true, replace: true });
            });
        }
        if (!this.model.get('races')) {
            this.model.set('races', new Ets.Collections.races);
        }
        this.super();
    },
    events: {
        'form submit' : 'submit',
        'click button[type="submit"]': 'submit',
    },
    createRace: function (event) {
        var self = this,
            division = $(event.currentTarget).closest('div').find('input').val();

        this.model.get('races').create({ 
            division: division,
            event_id: this.model.id 
        }, {
            success: function () {
                self.render();
            }
        });
    },
    createSplitTemplate: function (event) {
        var self     = this,
            $input   = $(event.currentTarget).closest('div').find('input'),
            label    = $input.val(),
            raceId   = $input.data('race-id'),
            template = this.model.get('races').get(raceId).get('split_templates').create({
                race_id: raceId,
                label: label
            }, {
                success: function () {
                    self.render();
                }
            });
    },
    deleteRace: function (event) {
        var self    = this,
            $button = $(event.currentTarget),
            raceId  = $button.data('race-id'),
            race    = this.model.get('races').get(raceId);

        race.destroy({
            success: function () {
                self.render();
            }
        });
    },
    import: function () {
        this.model.save({ import: true });
    },
    delete: function () {
        this.model.destroy({
            success: function () {
                Ets.router.navigate('events', { trigger: true });
            }
        });
    },
    deleteSplitTemplate: function (event) {
        var self    = this,
            $button = $(event.currentTarget),
            id      = $button.data('split-template-id');

        Ets.split_templates.get(id).destroy({
            success: function () {
                self.render();
            }
        });
    },
    submit: function (event) {
        var self = this,
            id   = this.model.id;

        event.preventDefault();
        this.model.save({}, {
            success: function () {
                if(!id) Ets.router.navigate('events/' + self.model.id + '/edit');
            }
        });
    },

    render: function () {
        this.$el.html(this.template({ event: this.model }));
    },
    template: JST['events/newdit']
});

Ets.Views.events.edit = Ets.Views.events.new.extend();
