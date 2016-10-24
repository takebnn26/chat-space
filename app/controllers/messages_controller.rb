class MessagesController < ApplicationController

  def index
    @messages = Message.all
    @message = Message.new
  end

  def create
    message = Message.new(message_params)

    if message.save(message_params)
      redirect_to messages_path
    else
      render root_path
    end

  end

  private

   def message_params
    params.require(:message).permit(:content)
   end

end
