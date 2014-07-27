window.Ets = {
    Models: {},
    Collections: {},
    Views: {},
    Routers: {},
    initialize: function() {
        Ets.router          = new Ets.Routers.mainRouter();
        Ets.events          = new Ets.Collections.events();
        Ets.races           = new Ets.Collections.races();
        Ets.split_templates = new Ets.Collections.split_templates();
        Ets.splits          = new Ets.Collections.splits();
        Ets.entries         = new Ets.Collections.entries();
        Ets.nav             = new Ets.Views.nav();
    }
};

Ets.Views.base = Backbone.View.extend({
    super: function () {
        $.extend(this.events, Ets.Views.base.prototype.events);
    },
    drawMap: function () {
        var mapOptions = {
              center: new google.maps.LatLng(41.079284, -85.139604),
              zoom: 10
            },
            mapEl = document.getElementById("map-canvas");

        this.map = new google.maps.Map(mapEl, mapOptions);
        $(mapEl).css('height', '400px');
    },
    setLocation: function (location) {
        var view = this,
            callback = function (results, status) {
              if (status == google.maps.places.PlacesServiceStatus.OK) {
                for (var i = 0; i < results.length; i++) {
                  var place = results[i];
                  createMarker(results[i]);
                }
              }
            },
            infowindow = new google.maps.InfoWindow(),
            createMarker = function (place) {
                var placeLoc = place.geometry.location,
                    marker = new google.maps.Marker({
                    map: view.map,
                    position: place.geometry.location
                });

                google.maps.event.addListener(marker, 'click', function() {
                    infowindow.setContent(place.name);
                    console.log(place);
                    infowindow.open(view.map, this);
                });
            },
            request = { query: location, location: new google.maps.LatLng(41.079284, -85.139604), radius: 500 },
            service = new google.maps.places.PlacesService(this.map);

        service.textSearch(request, callback);
    },
    events: {
        'change select[name], input[name], textarea[name]': 'changeValue',
        'blur [contenteditable]': 'changeValue',
        'click [data-function]': 'buttonFunction',
        'submit form': 'prevent'
    },
    prevent: function (event) {
        event.preventDefault();
    },
    buttonFunction: function (event) {
        var $button = $(event.currentTarget),
            func    = $button.data('function');

        event.stopPropagation();
        if (this[func]) this[func](event);
    },
    changeValue: function (event) {
        var self      = this,
            $input    = $(event.currentTarget),
            $form     = $input.closest('form'),
            key       = $input.prop('name') || $input.data('name'),
            value     = $input.val() || $input.text(),
            modelType = $form.data('model-type'),
            modelId   = $form.data('model-id');

        if (modelType) {
            model = Ets[modelType].get(modelId);
        } else {
            model = this.model;
        }
        if (model) {
            model.set(key, value);
            model.save();
        }
    },
});

$(document).ready(function(){
    Ets.initialize();
    Backbone.history.start({ pushState: true });
    $('#current-user').remove();
    Ets.admin = !!(Ets.current_user && Ets.current_user.admin);

    //handle links
    if (Backbone.history && Backbone.history._hasPushState) {
        $(document).delegate("a", "click", function(event) {
            var href = $(this).attr("href"),
                protocol = this.protocol + "//";

            if (href.slice(0, protocol.length) !== protocol) {
                event.preventDefault();
                Backbone.history.navigate(href, true);
            }
        });
    }
});
