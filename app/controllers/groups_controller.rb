class GroupsController < ApplicationController

  def show
    @group = Group.find(params[:id])
    @message = Message.new
    @groups = Group.all
  end

end
