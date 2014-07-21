class RacesController < ApplicationController
    def create
        @race = Race.new(race_params)
        if @race.save
            render json: @race
        else
            render status: 400
        end
    end

    def destroy
        @race = Race.find(params[:id])
        if @race.destroy
            head status: 204
        else
            head status: 400
        end
    end

    def index
        @races = Race.all
        render json: @races
    end

    def show
        @race = Race.includes(:split_templates, :event, :users, :entries).find(params[:id])
        render json: @race.as_json(include: [:split_templates, :event, :users, entries: { include: :splits }])
    end

    def update
        @race = Race.find(params[:id])
        if @race.update_attrubutes(race_params)
            render json: @race
        else
            head status: 400
        end
    end

    private
        def race_params
            params.require(:race).permit(
                :division,
                :event_id
            )
        end
end
