class UsersController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :check_login, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "controller.user.sign_up_success"
      redirect_to root_path
    else
      render :new
    end
  end

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
    params.require(:user).permit :name, :email, :password, :password_confirmation, :avatar
  end

  def get_user
    @user = User.find_by_id params[:id]
    return @user if @user
    flash[:danger] = t "controller.user.not_found"
    redirect_to root_path
  end

  def check_login
    unless logged_in?
      flash[:danger] = t("controller.comment.not_login")
      redirect_to root_path
    end
  end
end
