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
        if (this.filterCollection) this.filterCollection();
        this.$el.html(this.template({ events: this.collection }));
    },
    template: JST['events/index']
});

Ets.Views.events.calendar = Ets.Views.events.index.extend({
    initialize: function () {
        this.generateCalendarEvents();
    },
    render: function () {
        var view = this;

        this.$el.html(this.template({ events: this.collection }));
        $('#events-calendar').fullCalendar({
            events: view.calendarEvents,
            eventClick: function(calEvent, jsEvent, view) {
                Ets.router.navigate('/events/' + calEvent.id, { trigger: true });
            }
        });
    },
    template: JST['events/calendar']
});

Ets.Views.events.results  = Ets.Views.events.index.extend({
    initialize: function () {
        var view = this;

        this.listenTo(this.collection, 'add remove sync', this.render);
        this.collection.comparator = 'start_time';
        this.collection.sort();
        this.super();
    },
    filterCollection: function () {
        var models = [];

        this.collection.each(function (model) {
            if (!(moment(model.get('start_time')).isBefore(moment().add('day', 1), 'day'))) {
                models.push(model);
            }
        });
        this.collection.remove(models);
    }
});

Ets.Views.events.upcoming = Ets.Views.events.index.extend({
    initialize: function () {
        this.listenTo(this.collection, 'add remove sync', this.render);
        this.collection.comparator = 'start_time';
        this.collection.sort();
        this.collection.models.reverse();
        this.super();
    },
    filterCollection: function () {
        var models = [];

        this.collection.each(function (model) {
            if (moment(model.get('start_time')).isBefore(moment().add('day', 1), 'day')) {
                models.push(model);
            }
        });
        this.collection.remove(models);
    }
});

Ets.Views.events.show = Ets.Views.base.extend({
    initialize: function () {
        this.super();
    },
    render: function () {
        this.$el.html(this.template({ event: this.model }));
        this.drawMap();
        this.showLocation(true);
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
        'mousedown div.cover-photo': 'repoCoverPhoto'
    },

    addContact: function (event) {
        var self       = this,
            $button    = $(event.currentTarget),
            $form      = $button.closest('form'),
            $select    = $form.find('select'),
            contactId  = $select.val(),
            eventId    = this.model.id,
            assocModel = new Ets.Models.AssocContactEvent;

        if (!this.model.id) alert('Please save event before making associations.');

        assocModel.save({
            event_id: eventId,
            event_contact_id: contactId
        }, {
            success: function () {
                self.model.get('event_contacts').add(Ets.event_contacts.get(contactId));
                self.render();
            }
        });

    },

    createContact: function (event) {
        var self    = this,
            $button = $(event.currentTarget),
            $form   = $button.closest('form'),
            $inputs = $form.find('input'),
            props   = { event_id: this.model.id };

        $inputs.each(function (idx, input) {
            var $input = $(input),
                value  = input.type === 'checkbox' ? $input.prop('checked') : $input.val();

            props[$input.prop('name')] = value;
        });

        this.model.get('event_contacts').create(props,{
            success: function (model) {
                self.model.get('assoc_contact_events').create({
                        event_contact_id: model.id,
                        event_id: self.model.id
                }, {
                    success: self.render.bind(self)
                });
            }
        });
    },


    deleteContact: function (event) {
        var self = this,
            $button = $(event.currentTarget),
            $tr     = $button.closest('tr'),
            modelId = $tr.data('model-id'),
            model   = this.model.get('assoc_contact_events').findWhere({ event_contact_id: modelId });

        if (model) {
            model.destroy({
                success: function () {
                    self.model.get('event_contacts').remove(modelId);
                    self.render();
                }
            });
        }
    },

    addInteraction: function (event) {
        var self    = this,
            $button = $(event.currentTarget),
            $form   = $button.closest('form'),
            $inputs = $form.find('input'),
            props   = { event_id: this.model.id };

        $inputs.each(function (idx, input) {
            var $input = $(input),
                value  = input.type === 'checkbox' ? $input.prop('checked') : $input.val();

            props[$input.prop('name')] = value;
        });

        this.model.get('interactions').create(props,{
            success: function () {
                self.render();
            }
        });
    },

    deleteInteraction: function (event) {
        var $button = $(event.currentTarget),
            $tr     = $button.closest('tr'),
            modelId = $tr.data('model-id'),
            model   = this.model.get('interactions').get(modelId);

        model.destroy({ success: this.render.bind(this) });
    },

    liveUpdate: function (event) {
        var self     = this,
            $button  = $(event.currentTarget),
            interval = parseInt($button.closest('span').siblings('input').val()) || 60;

        this.interval = setInterval(function () {
            self.update();
        }, interval * 1000);
        $button.html('Stop!').removeClass('btn-success').addClass('btn-danger').data('function', 'stopLiveUpdates');
    },
    stopLiveUpdates: function (event) {
        var self = this,
            $button = $(event.currentTarget);

        $button.html('Seconds').removeClass('btn-danger').addClass('btn-success').data('function', 'liveUpdate');
        clearInterval(this.interval);
    },
    repoCoverPhoto: function (event) {
        var view   = this,
            $cover = $(event.currentTarget),
            bg_pos = $(event.currentTarget).css('background-position').split(' ')[1],
            y_pos  = parseInt(bg_pos.slice(0, bg_pos.length - 1));
            y = event.pageY;

        event.preventDefault();
        $cover.on('mousemove', function (event) {
            var y_diff  = (event.pageY - y)/4,
                css_y = y_pos - y_diff;

            event.preventDefault();
            if (css_y < 0) css_y = 0;
            if (css_y > 100) css_y = 100;
            $cover.css('background-position', 'center ' + css_y + '%');
            view.model.save({ cover_position: css_y });
        });
        $('body').on('mouseup', function () {
            $cover.off();
        });
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
        var self = this;

        $('input').prop('disabled', true);

        this.model.save({ import: true }, {
            success : self.render.bind(self),
            error   : self.render.bind(self)
        });
    },
    update: function () {
        var self = this;

        $('input').prop('disabled', true);

        this.model.save({ update: true },{
            success : self.render.bind(self),
            error   : self.render.bind(self)
        });
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
        var view   = this,
            scroll = $('body').scrollTop();

        this.$el.html(this.template({ event: this.model, event_contacts: Ets.event_contacts }));
        this.drawMap();
        this.showLocation();
        tinymce.editors.every(function (editor) { editor.destroy() });
        tinymce.init({
            selector: 'textarea',
            init_instance_callback : "Ets.submitTinyMCE"
        });

        Ets.submitTinyMCE = function () {
            tinymce.activeEditor.on('Change', function () {
                var content = this.getContent();
                view.model.set({ description: content });
            });
        }

        $('body').scrollTop(scroll);
    },
    template: JST['events/newdit']
});

Ets.Views.events.edit = Ets.Views.events.new.extend();
