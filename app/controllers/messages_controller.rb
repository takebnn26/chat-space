class MessagesController < ApplicationController

  def index
    @messages = Message.all
    @message = Message.new
  end

  def create
    message = Message.new(message_params)

    if message.save(message_params)
      redirect_to root_path, notice: 'メッセージ送信成功'
    else
      redirect_to root_path, alert: 'メッセージ送信失敗'
    end

  end

  private

   def message_params
    params.require(:message).permit(:content)
   end

end
