Ets.Views.events = {};

Ets.Views.events.index = Backbone.View.extend({
    render: function () {
        this.$el.html(this.template({ events: this.collection }));
    },
    template: JST['events/index']
});

Ets.Views.events.new = Backbone.View.extend({
    initialize: function () {
        this.listenTo(this.model, 'sync', this.render);
        if (!this.model.get('races')) {
            this.model.set('races', new Ets.Collections.races);
        }
    },
    events: {
        'change input[name]': 'changeValue',
        'form submit' : 'submit',
        'click button[type="submit"]': 'submit',
        'click button[data-function]': 'buttonFunction'
    },
    buttonFunction: function (event) {
        var $button = $(event.currentTarget),
            func    = $button.data('function');

        event.preventDefault();
        if (this[func]) this[func](event);
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
    changeValue: function (event) {
        var $input = $(event.currentTarget),
            key    = $input.prop('name'),
            value  = $input.val();

        this.model.set(key, value);
    },
    render: function () {
        this.$el.html(this.template({ event: this.model }));
    },
    template: JST['events/newdit']
});

Ets.Views.events.edit = Ets.Views.events.new.extend();
