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

  def facebook
    data = HTTParty.get("https://graph.facebook.com/me?fields=id,name,email&access_token=#{params[:accessToken]}")
    response = data.to_h
    social_account = Social_account.find_by_provider_id response["id"]
    if social_account
      user = social_account.user
      log_in user
    else
      user = User.new(name: response["name"], email: response["email"], coin: 0, password: Settings.password_default)
      if user.save
        Social_account.create(provider: "facebook", provider_id: response["id"], user_id: user.id)
        log_in user
      else
        flash[:danger] = t "controller.sessions.login_error"
      end
    end
    redirect_to root_path
  end
end
