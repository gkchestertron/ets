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
        query = request.query_parameters
        @events = Event.where(query).includes(:races).order(:id)
        render json: @events.as_json(include: :races)
    end

    def show
        @event = Event.includes(:races, :interactions, :event_contacts, :assoc_contact_events).find(params[:id])
        render json: @event.as_json(include: [:interactions, :assoc_contact_events, :event_contacts, {races: { include: :split_templates } }])
    end

    def update
        @event = Event.find(params[:id])
        if @event.update_attributes(event_params)
            if params[:import]
                @event.import
            end
            if params[:update]
                @event.update_entries
            end
            render json: @event.as_json(include: [races: { include: :split_templates }])
        else
            render status: 400
        end
    end

    private
        def event_params
            params.require(:event).permit(
              :id,
              :is_visible,
              :name,
              :location,
              :date_time,
              :description,
              :import_path,
              :user_field_1_label,
              :user_field_2_label,
              :user_field_3_label,
              :created_at,
              :updated_at,
              :place_id,
              :database_file_path,
              :division_file_path,
              :group_file_path,
              :finishers_only,
              :cover_photo,
              :cover_position,
              :start_time,
              :end_time,
              :live_update_interval,
              :event_type_id,
              :website,
              :street,
              :city,
              :state,
              :zip,
              :number_of_participants,
              :online_registration_link,
              :billing_contact_id,
              :notes,
              :results_url,
              :course_map_url,
              :timer_id,
              :event_group_id
            )
        end
end
