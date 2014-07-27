class EntriesController < ApplicationController
  def create
      @entry = Entry.new(params[:entry])
      if @entry.save
          render json: @entry
      else
          render status: 400
      end
  end

  def destroy
      @entry = Entry.find(params[:id])
      if @entry.destroy
          render status: 200
      else
          render status: 400
      end
  end

  def index
      if params[:user_id]
          @entries = User.find(params[:user_id]).entries
      elsif params[:race_id]
          @entries = Race.find(params[:race_id]).entries
      end
      render json: @entries
  end

  def show
      name_split = params[:id].split('_')
      first_name = name_split[0]
      last_name  = name_split[1]
      if name_split.length
          @entry = Entry.includes(:user, :race, :splits).where(first_name: first_name, last_name: last_name)
      else
          @entry = Entry.includes(:user, :race, :splits).find(params[:id])
      end
      render json: @entry.as_json(include: [:user, :race, :splits])
  end

  def update
      @entry = Entry.find(params[:id])
      if @entry.update_attributes(params[:entry])
          render json: @entry
      else
          render status: 400
      end
  end
end
