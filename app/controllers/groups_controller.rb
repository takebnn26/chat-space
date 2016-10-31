class GroupsController < ApplicationController

  before_action :set_group, only: [:edit, :update, :show]

  def new
    @group = Group.new
    @users = User.all.where.not(id: current_user.id)
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      GroupUser.create(user_id: current_user.id, group_id: @group.id)
      redirect_to group_path(@group), notice: '新規グループを作成しました'
    else
      flash[:alert] = '新規グループ作成に失敗しました'
      render :new
    end

  end

  def edit
    @users = User.all.where.not(id: current_user.id)
  end

  def update

    if @group.update(group_params)
      redirect_to group_path(@group), notice: 'グループ情報を更新しました'
    else
      redirect_to edit_group_path(@group), alert: 'グループ情報更新に失敗しました'
    end

  end

  def show
    @message = Message.new
    @groups = current_user.groups
  end

  private

  def group_params
    params.require(:group).permit(:name, { user_ids: [] })
  end

  def set_group
    @group = Group.find(params[:id])
  end

end
