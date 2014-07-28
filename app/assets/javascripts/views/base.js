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

        $(mapEl).css('height', '400px');
        this.map = new google.maps.Map(mapEl, mapOptions);
    },
    setLocation: function (event) {
        var view = this,
            place_id = $(event.currentTarget).data('place_id'),
            request = {
                placeId: place_id
            },
            service = new google.maps.places.PlacesService(this.map);

        function callback(place, status) {
            if (status == google.maps.places.PlacesServiceStatus.OK) {
                window.place = place;
                view.map.setCenter(place.geometry.location);
                view.model.save({ place_id: place_id, location: place.name }, {
                    success: function () {
                        view.render();
                    }
                });
            }
        }

        service.getDetails(request, callback);
    },
    showLocation: function (showInfo) {
        var view = this,
            place_id = this.model.get('place_id'),
            request = { placeId: place_id },
            service = new google.maps.places.PlacesService(this.map);

        this.infoWindow = new google.maps.InfoWindow();
        function callback(place, status) {
            var content = view.markerTemplate({ place: place }),
                marker;

            if (status == google.maps.places.PlacesServiceStatus.OK) {
                view.map.setCenter(place.geometry.location);
                marker = view.createMarker(place);
                if (showInfo) {
                    view.infoWindow = new google.maps.InfoWindow();
                    view.infoWindow.setContent(content);
                    view.infoWindow.open(view.map, marker);
                    view.map.panBy(0, -50);
                }
            }
        }

        if (place_id) service.getDetails(request, callback);
    },
    findLocation: function (event) {
        var view = this,
            callback = function (results, status) {
                if (status == google.maps.places.PlacesServiceStatus.OK) {
                    for (var i = 0; i < results.length; i++) {
                        var place = results[i];
                        view.createMarker(results[i]);
                    }
                    view.map.setCenter(results[0].geometry.location);
                }
            },
            location = $(event.currentTarget).val(),
            request = { query: location, location: new google.maps.LatLng(41.079284, -85.139604), radius: 500 },
            service = new google.maps.places.PlacesService(this.map);

        this.infoWindow = new google.maps.InfoWindow();
        service.textSearch(request, callback);
    },
    createMarker: function (place) {
        var view = this,
            placeLoc = place.geometry.location,
            marker = new google.maps.Marker({
                map: view.map,
                position: place.geometry.location
            });

        view.infoWindow = new google.maps.InfoWindow();

        google.maps.event.addListener(marker, 'click', function() {
            var content = view.markerTemplate({ place: place });

            view.infoWindow.setContent(content);
            view.map.setCenter(place.geometry.location);
            view.infoWindow.open(view.map, this);
        });
        return marker;
    },
    events: {
        'change select[name], input[name], textarea[name]': 'changeValue',
        'blur [contenteditable]': 'changeValue',
        'click [data-function]': 'buttonFunction',
        'change [data-function]': 'buttonFunction',
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
    render: function () {
        var vars =  { model: this.model, collection: this.collection };
        this.$el.html(this.template(vars));
    },
    markerTemplate: JST['events/marker']
});
