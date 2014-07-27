class SplitTemplatesController < ApplicationController
    def create
        @split_template = SplitTemplate.new(split_template_params)
        if @split_template.save
            render json: @split_template
        else
            head status: 400
        end
    end

    def destroy
        @split_template = SplitTemplate.find(params[:id])
        if @split_template.destroy
            head status: 204
        else
            head status: 400
        end
    end

    def show
        head status: 200
    end

    def update
        @split_template = SplitTemplate.find(params[:id])
        if @split_template.update_attributes(split_template_params)
            render json: @split_template
        else
            head status: 400
        end
    end

    private
    def split_template_params
        params.require(:split_template).permit(
            :label,
            :diff_field_1,
            :diff_field_2,
            :order,
            :race_id,
            :distance
        )
    end
end
