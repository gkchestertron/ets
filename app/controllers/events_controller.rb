class EventsController < ApplicationController
    def create
        @event = Event.new(event_params)
        if @event.save
            render json: @event
        else
            render status: 400
        end
    end

    def destroy
        @event = Event.find(params[:id])
        if @event.destroy
            head status: 204
        else
            head status: 400
        end
    end

    def index
        @events = Event.all.includes(:races)
        render json: @events.as_json(include: :races)
    end

    def show
        @event = Event.includes(:races).find(params[:id])
        render json: @event.as_json(include: [races: { include: :split_templates }])
    end

    def update
        @event = Event.find(params[:id])
        if @event.update_attributes(event_params)
            if params[:import]
                @event.import
            end
            render json: @event.as_json(include: :races)
        else
            render status: 400
        end
    end

    private
        def event_params
            params.require(:event).permit(
                :name, 
                :location,
                :date_time,
                :description,
                :import_path,
                :user_field_1_label,
                :user_field_2_label,
                :user_field_3_label,
                :import
            )
        end
end
