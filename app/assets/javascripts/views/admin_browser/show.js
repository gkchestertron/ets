Ets.Views.AdminBrowser = Ets.Views.AdminBrowser || {};

Ets.Views.AdminBrowser.Show = Backbone.View.extend({
    events: {
        'click td': 'showModal',
        'click .save-data': 'saveData'
    },

    render: function () {
        var vars =  { model: this.model, collection: this.collection };
        this.$el.html(this.template(vars));
    },

    saveData: function (event) {
        var self      = this,
            $button   = $(event.currentTarget),
            $modal    = $button.closest('.modal'),
            $textarea = $modal.find('textarea'),
            modelId   = $button.data('model-id'),
            model     = this.collection.get(modelId),
            attrName  = $button.data('attr-name'),
            value     = $textarea.val();

        if (value.trim && value.trim() === 'true') value = true;
        if (value.trim && value.trim() === 'false') value = false;

        model.set(attrName, value);
        model.save({}, {
            success: function () {
                $('.modal-backdrop').remove();
                self.render();
            },
            error: function () {
                alert(arguments);
            }
        });
    },

    showModal: function (event) {
        var $td      = $(event.currentTarget),
            $tr      = $td.closest('tr'),
            modelId  = $tr.data('model-id'),
            model    = this.collection.get(modelId),
            attrName = $td.data('attr-name'),
            attr     = model.get(attrName),
            $modal   = $('#admin_modal');

        $modal.find('.modal-body textarea').html(attr);
        $modal.find('.save-data').data('model-id', modelId);
        $modal.find('.save-data').data('attr-name', attrName);
        $modal.modal('show');
        $modal.on('shown.bs.modal', function () {
            $('body').css({ 'overflow-y': 'scroll' });
        });
    },

    template: JST['admin_browser/show'],
});
