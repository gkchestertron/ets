window.Ets = {
    Models: {},
    Collections: {},
    Views: {},
    Routers: {},
    initialize: function() {
        Ets.races = new Ets.Collections.Races();
        Ets.router = new Ets.Routers.mainRouter();
    }
};

$(document).ready(function(){
    Ets.initialize();
    Backbone.history.start({ pushState: true });

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
