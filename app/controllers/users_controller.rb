class UsersController < ApplicationController

  before_action :set_user
  before_action -> {comfirm_user(@user)}

  def edit
  end

  def update

    if @user.update_with_password(user_params)
      redirect_to root_path, notice: "ユーザーの情報を更新しました。"
    else
      flash[:alert] = "ユーザーの情報更新に失敗しました。"
      render :edit
    end

  end


  private

  def user_params
    params.require(:user).permit(
                                :name,
                                :email,
                                :password,
                                :current_password,
                                :password_comfirmation
                                )
  end

  def set_user
    @user = User.find(params[:id])
  end

end
