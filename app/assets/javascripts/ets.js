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
        Ets.groups          = new Ets.Collections.groups();
        Ets.group_defaults  = new Ets.Collections.group_defaults();
        Ets.nav             = new Ets.Views.nav();
        Ets.event_contacts  = new Ets.Collections.EventContacts();
    }
};


$(document).ready(function(){
    // initialize and establish admin state
    Ets.initialize();
    Backbone.history.start({ pushState: true });
    $('#current-user').remove();
    Ets.admin = !!(Ets.current_user && Ets.current_user.admin);
        
    //handle links
    if (Backbone.history && Backbone.history._hasPushState) {
        $(document).delegate("a", "click", function(event) {
            var href = $(this).attr("href"),
                protocol = this.protocol + "//";

            if (href[0] === "#") {
                return false;
            }
            if (href.slice(0, protocol.length) !== protocol) {
                event.preventDefault();
                Backbone.history.navigate(href, true);
            } else {
                $(this).prop('target', '_blank');
            }
        });
    }
});
