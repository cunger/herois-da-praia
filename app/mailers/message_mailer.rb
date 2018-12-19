class MessageMailer < ApplicationMailer

  def forward
    @message = params[:message]
    mail(to: 'buoyantcode@gmail.com', subject: "[herois-da-praia] #{@message.name} sent a message")
  end
end
