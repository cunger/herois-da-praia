class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.valid?
      MessageMailer.with(message: @message).forward.deliver

      flash[:success] = 'Thanks! We got your message.'
      redirect_to contact_path
    else
      flash[:error] = 'Please make sure to fill in all fields.'
      render :new
    end
  end

  private

  def message_params
    params.fetch(:message, {})
          .permit(:name, :email, :text)
          .merge({ timestamp: Time.now })
  end
end
