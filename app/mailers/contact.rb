class Contact < ActionMailer::Base
  default from: "contact@elitetimingsolutions.com"

  def email_john(params)
      @params = params
      mail(to: 'john.fellman@gmail.com', subject: params[:subject])
  end

  def email_tim(params)
      @params = params
      mail(to: 'tim@elitetimingsolutions.com', subject: params[:subject])
  end
end
