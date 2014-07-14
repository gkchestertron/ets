class EventsController < ApplicationController
    def create
        @event = Event.new(params[:event])
        if @event.save
            render json: @event
        else
            render status: 400
        end
    end

    def destroy
        @event = Event.find(params[:id])
        if @event.destroy
            render status: 400
        else
            render status: 200
        end
    end

    def index
        @events = Event.all
        render json: @events
    end

    def show
        @event = Event.includes(:races).find(params[:id])
        render json: @event.as_json(include: :races)
    end

    def update
        @event = Event.find(params[:id])
        if @event.update_attrubutes(params[:event])
            render json: @event
        else
            render status: 400
        end
    end
end
