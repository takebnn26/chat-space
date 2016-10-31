class GroupsController < ApplicationController

  before_action :set_group, only: [:edit, :update, :show]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to group_path(@group), notice: '新規グループを作成しました'
    else
      flash[:alert] = '新規グループ作成に失敗しました'
      render :new
    end

  end

  def edit
  end

  def update
    @group = Group.find(params[:id])

    if @group.users.include?(current_user)
      if @group.update(group_params)
        redirect_to group_path(@group), notice: 'グループ情報を更新しました'
      else
        flash[:alert] = 'グループ情報更新に失敗しました'
        render :edit
      end
    else
      redirect_to group_path(@group), alert: '更新を許可されていません'
    end

  end

  def show
    @message = Message.new
    @groups = current_user.groups.all
  end

  private

  def group_params
    params.require(:group).permit(:name, { user_ids: [] })
  end

  def set_group
    @group = Group.find(params[:id])
  end

end
