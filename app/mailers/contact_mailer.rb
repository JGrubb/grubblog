class ContactMailer < ActionMailer::Base
  
  default :to => "therealjohnnygrubb@gmail.com"

  def new_message(message)
    @message = message
    mail( :from           => @message.name, 
          :subject        => "johnnygrubb.com contact",
          :template_path  => "contact_mailer",
          :template_name  => "contact_email")
  end
  
end