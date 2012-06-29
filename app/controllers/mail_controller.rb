class MailController < ApplicationController
  
  def contact
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])

    if @message.valid?
      ContactMailer.new_message(@message).deliver
      redirect_to(root_path, :notice => "Message was successfully sent.")
    else
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end
  
end
