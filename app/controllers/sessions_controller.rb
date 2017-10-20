class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      log_in user
      redirect_to root_path
    else
      flash[:danger] = t "controller.sessions.login_error"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
