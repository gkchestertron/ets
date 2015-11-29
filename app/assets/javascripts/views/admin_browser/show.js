Ets.Views.AdminBrowser = Ets.Views.AdminBrowser || {};

Ets.Views.AdminBrowser.Show = Backbone.View.extend({
    events: {
        'click td'                                  : 'showModal',
        'click .save-data'                          : 'saveData',
        'click button[data-function="deleteModel"]' : 'deleteModel',
        'click th'                                  : 'sort'
    },

    deleteModel: function (event) {
        var $button = $(event.currentTarget),
            $tr     = $button.closest('tr'),
            modelId = $tr.data('model-id'),
            model   = this.collection.get(modelId);

        model.destroy({ success: this.render.bind(this) });
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

        if (!attrName || attrName === 'id') return;

        $modal.find('.modal-body textarea').html(attr);
        $modal.find('.save-data').data('model-id', modelId);
        $modal.find('.save-data').data('attr-name', attrName);
        $modal.modal('show');
    },

    sort: function (event) {
        var $th        = $(event.currentTarget),
            comparator = $th.data('comparator'),
            prevComp   = this.collection.comparator,
            $arrows,
            arrow;

        this.collection.comparator = comparator || 'id';
        if (prevComp === comparator) {
            this.collection.models.reverse();
            arrow = '.glyphicon-arrow-down';
        } else {
            this.collection.sort();
            arrow = '.glyphicon-arrow-up';
        }
        this.render();
        $('th span').show();
        $arrows = $('th[data-comparator="' + comparator + '"] div.sort-arrows'),
        $arrows.find(arrow).hide();
    },

    template: JST['admin_browser/show'],
});
