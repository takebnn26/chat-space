class GroupsController < ApplicationController

  before_action :set_group, only: [:edit, :update, :show]

  def index
    @groups = current_user.groups if current_user.groups
  end

  def new
    @group = Group.new
    @group.users << current_user
    @users = User.all.where.not(id: current_user.id)
  end

  def create
    @group = Group.new(group_params)
    @group.users << current_user

    if @group.save
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
