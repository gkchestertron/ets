class InteractionsController < ApplicationController
    def create
    interaction = Interaction.new(interaction_params)
    if interaction.save
      render json: interaction
    else
      head 400
    end
  end

  def destroy
    interaction = Interaction.find(params[:id])
    if interaction.destroy
      head 204
    else
      head 400
    end
  end

  def index
    render json: Interaction.all.order(:id)
  end

  def show
    interaction = EventContact.find(params[:id])
    if interaction
      render json: interaction
    else
      head 400
    end
  end

  def update
    interaction = Interaction.find(params[:id])
    if interaction.update_attributes(interaction_params)
      render json: interaction
    else
      head 400
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
