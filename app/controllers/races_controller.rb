class RacesController < ApplicationController
    def create
        @race = Race.new(params[:race])
        if @race.save
            render json: @race
        else
            render status: 400
        end
    end

    def destroy
        @race = Race.find(params[:id])
        if @race.destroy
            render status: 400
        else
            render status: 200
        end
    end

    def index
        @races = Race.all
        render json: @races
    end

    def show
        @race = Race.includes(:users, :entries).find(params[:id])
        render json: @race.as_json(include: [:users, entries: { include: :splits }])
    end

    def update
        @race = Race.find(params[:id])
        if @race.update_attrubutes(params[:race])
            render json: @race
        else
            render status: 400
        end
    end
end
