class MessagesController < ApplicationController

  before_action :set_group

  def index
    @groups = current_user.groups
    @message = Message.new
  end

  def create
    message = current_user.messages.new(message_params)
    if message.save
      respond_to do |format|
        format.html do
          redirect_to group_messages_path(@group), notice: 'メッセージ送信成功'
        end
        format.json do
          render json: {
                          content:  message.content,
                          name:     message.user.name,
                          date:     message.created_at.strftime('%Y/%m/%d %H:%M:%S'),
                          notice:   'メッセージ送信成功',
                        }
        end
      end
    else
      redirect_to group_messages_path(@group)
    end

  end

  private

   def message_params
    params.require(:message).permit(:content).merge(group_id: params[:group_id])
   end

   def set_group
    @group = Group.find(params[:group_id])
   end

end
