class ContactsController < ApplicationController
  def create
    contact = EventContact.new(contact_params)
    if contact.save
      render json: contact
    else
      render status: 400
    end
  end

  def destroy
    contact = EventContact.find(params[:id])
    if contact.destroy
      render status: 204
    else
      render status: 400
    end
  end

  def index
    render json: EventContact.all.order(:id)
  end

  def show
    contact = EventContact.find(params[:id])
    if contact
      render json: contact
    else
      render status: 400
    end
  end

  def update
    contact = EventContact.find(params[:id])
    if contact.update_attributes(contact_params)
      render json: contact
    else
      render status: 400
    end
  end


  private
    def contact_params
      params.require(:contact).permit(
        :id,
        :company_name,
        :first_name,
        :last_name,
        :title,
        :email,
        :phone,
        :street,
        :city,
        :state,
        :zip,
        :notes
      )
    end
end
