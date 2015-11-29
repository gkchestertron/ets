Ets.Models.EventContact = Backbone.Model.extend({
    fullname: function () {
        var first_name = this.get('first_name'),
            last_name  = this.get('last_name'),
            comp_name  = this.get('company_name'),
            email      = this.get('email');

        if (first_name && last_name) return first_name + ' ' + last_name;
        return comp_name || email;
    },

    urlRoot: '/event_contacts/'
});
