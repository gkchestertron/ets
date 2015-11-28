class InteractionsController < ApplicationController
    def create
    interaction = EventContact.new(interaction_params)
    if interaction.save
      render json: interaction
    else
      render status: 400
    end
  end

  def destroy
    interaction = EventContact.find(params[:id])
    if interaction.destroy
      render status: 204
    else
      render status: 400
    end
  end

  def index
    render json: EventContact.all.order(:id)
  end

  def show
    interaction = EventContact.find(params[:id])
    if interaction
      render json: interaction
    else
      render status: 400
    end
  end

  def update
    interaction = EventContact.find(params[:id])
    if interaction.update_attributes(interaction_params)
      render json: interaction
    else
      render status: 400
    end
  end

  private
    def interaction_params
      params.require(:interaction).permit(
        :event_id,
        :note,
        :created_at,
        :updated_at,
        :needs_contact,
        :date
      )
    end
end
