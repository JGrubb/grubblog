class ContactMailer < ActionMailer::Base
  
  default :from => "site@johnnygrubb.com"
  default :to => "therealjohnnygrubb@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "JG.com contact")
  end
  
end
