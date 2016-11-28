class MessagesController < ApplicationController

  before_action :set_group

  def index
    @groups = current_user.groups
    @message = Message.new
    respond_to do |format|
      format.html
      format.json { render json: @group.messages.includes(:user).map(&:tojson)}
    end
  end

  def create

    message = current_user.messages.new(message_params)
    if message.save
      respond_to do |format|
        format.html do
          redirect_to group_messages_path(@group), notice: 'メッセージ送信成功'
        end
        format.json do
          render json: message.tojson
        end
      end
    else
      redirect_to group_messages_path(@group)
    end

  end

  private

   def message_params
    params.require(:message).permit(:content, :image).merge(group_id: params[:group_id])
   end

   def set_group
    @group = Group.find(params[:group_id])
   end

end
