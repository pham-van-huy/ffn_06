class UsersController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :check_login, only: [:edit, :update]

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "controller.user.update_success"
      redirect_to root_path
    else
      flash[:danger] = t "controller.user.fail_success"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :email, :avatar
  end

  def get_user
    @user = User.find_by_id params[:id]
    return @user if @user
    flash[:danger] = t "controller.user.not_found"
    redirect_to root_path
  end

  def check_login
    unless signed_in?
      flash[:danger] = t("controller.comment.not_login")
      redirect_to root_path
    end
  end
end
