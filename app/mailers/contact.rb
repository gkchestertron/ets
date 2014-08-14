class Contact < ActionMailer::Base
  default from: "contact@elitetimingsolutions.com"

  def email_john(params)
      @params = params
      mail(to: 'john.fellman@gmail.com', subject: params[:subject])
  end
end
