Ets.Views.home = Ets.Views.base.extend({
    initialize: function () {
        this.generateCalendarEvents();
    },
    render: function () {
        var view = this,
            i    = 0,
            active,
            futureEvents = this.filterCollection('future', 5),
            pastEvents   = this.filterCollection('past', 5);

        this.$el.html(this.template({ 
            collection: this.collection,
            futureEvents: futureEvents,
            pastEvents: pastEvents
        }));
        _.each(pastEvents.models.concat(futureEvents.models), function (event) {
            var text    = $('<div>' + event.get('description') + '</div>').text().slice(0, 255) + '...';

            if (!(event.get('cover_photo').url)) { 
                return false;
            }

            if (active === undefined) {
                active = 'active';
            } else {
                active = '';
            }

            view.$('ol.carousel-indicators')
                .append('<li data-target="#carousel-main" data-slide-to="' + i + '" class="' + active + '"></li>');
            view.$('div.carousel-inner').append('<div class="item ' + active + 
                '">' + '<div class="cover-photo" style="background-image: url(' + event.get('cover_photo').url +'); background-position: center ' + event.get('cover_position') + '%;"></div>' + 
                '<a href="/events/' + event.id + '"><div class="carousel-caption"><h4>' + 
                event.get('name') + '</h4><br>' + text + '</div></a>' + '</div>'
            );
            $('#carousel-main').carousel();
            i++;
        });
        $('#home-calendar').fullCalendar({
            events: view.calendarEvents,
            eventClick: function(calEvent, jsEvent, view) {
                Ets.router.navigate('/events/' + calEvent.id, { trigger: true });
            }
        });
    },
    template: JST['static/home']
});

Ets.Views.about = Ets.Views.base.extend({
    initialize: function () {
        var view = this; 

        window.view = this;
        this.content = new Ets.Models.contents({ title: 'about' });
        this.content.fetch({
            data: { content: view.content.attributes },
            success: function () {
                view.render('for real');
            }
        });
    },
    render: function (forReal) {
        var view = this;

        this.$el.html(this.template({ content: this.content }));
        if (forReal === 'for real' && Ets.admin) {
            tinymce.editors.every(function (editor) { editor.destroy() });
            tinymce.init({
                selector: '#about',
                init_instance_callback : "Ets.saveContent"
            });

            Ets.saveContent = function () {
                tinymce.activeEditor.on('Change', function () {
                    var content = this.getContent();
                    view.content.save({ body: content });
                });
            }
        }
    },
    template: JST['static/about']
});

Ets.Views.contact = Ets.Views.base.extend({
    initialize: function () {
        this.model = new Ets.Models.contact
        this.super();
    },
    events: {
        'click button': 'submit'
    },
    changeValue: function (event) {
        var $input = $(event.currentTarget),
            key    = $input.prop('name'),
            value  = $input.val();

        this.model.set(key, value);
    },
    submit: function (event) {
        event.preventDefault();
        this.model.save();
        this.$el.html('<h1>Thank You!</h1>');
    },
    template: JST['static/contact']
});
