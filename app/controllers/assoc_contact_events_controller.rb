class AssocContactEventsController < ApplicationController
    def create
    assoc = AssocContactEvent.new(assoc_params)
    if assoc.save
      render json: assoc
    else
      head 400
    end
  end

  def destroy
    assoc = AssocContactEvent.find(params[:id])
    if assoc.destroy
      head 204
    else
      head 400
    end
  end

  def index
    render json: AssocContactEvent.all.order(:id)
  end

  def show
    assoc = AssocContactEvent.find(params[:id])
    if assoc
      render json: assoc
    else
      head 400
    end
  end

  def update
    assoc = AssocContactEvent.find(params[:id])
    if assoc.update_attributes(assoc_params)
      render json: assoc
    else
      head 400
    end
  end

  private
    def assoc_params
      params.require(:assoc_contact_event).permit(
        :event_id,
        :event_contact_id
      )
    end
end
