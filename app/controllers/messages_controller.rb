class MessagesController < ApplicationController

  before_action :set_group

  def index
    @groups = current_user.groups
    @message = Message.new
  end

  def create

    message = @group.messages.new(message_params)

    if message.save(message_params)
      redirect_to group_messages_path(@group), notice: 'メッセージ送信成功'
    else
      redirect_to group_messages_path(@group), alert: 'メッセージ送信失敗'
    end

  end

  private

   def message_params
    params.require(:message).permit(:content, :user_id)
   end

   def set_group
    @group = Group.find(params[:group_id])
   end

end
