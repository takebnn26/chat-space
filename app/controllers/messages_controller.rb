class MessagesController < ApplicationController

  def index
    @groups = current_user.groups.all
  end

  def create

    message = Message.new(message_params)

    if message.save(message_params)
      redirect_to group_path(message.group), notice: 'メッセージ送信成功'
    else
      redirect_to group_path(message.group), alert: 'メッセージ送信失敗'
    end

  end

  private

   def message_params
    params.require(:message).permit(:content, :user_id, :group_id)
   end

end
