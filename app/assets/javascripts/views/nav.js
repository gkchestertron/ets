Ets.Views.nav = Ets.Views.base.extend({
    initialize: function () {
        this.setElement($('#main-nav'));
        this.listenTo(Ets.router, 'route', this.updateActive);
        this.super(arguments);
    },
    prevent: function () {
        //override
    },
    updateActive: function () {
        var href = Backbone.history.fragment.split('/')[0];

        this.$('.active').removeClass('active');
        this.$('[href="/' + href + '"]').closest('li').addClass('active');
        this.$('[href="' + href + '"]').closest('li').addClass('active');
    },
    showLogin: function (event) {
        this.$('.login-form').show();
        $(event.currentTarget).hide();
    },
    login: function (event) {
        console.log('logging in');
    }
});
