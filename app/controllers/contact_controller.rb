class ContactController < ApplicationController
    skip_before_action :admin_user
    def create
        if contact_params[:name] && contact_params[:body] && contact_params[:email]
            Contact.email_john(contact_params).deliver
            Contact.email_tim(contact_params).deliver
            head status: 200
        else
            head status: 400
        end
    end
    
    private

    def contact_params
        params.require(:contact).permit(:subject, :body, :name, :email, :phone)
    end
end
