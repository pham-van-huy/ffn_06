class SessionsController < ApplicationController
  def facebook
    data = HTTParty.get("https://graph.facebook.com/me?fields=id,name,email&access_token=#{params[:accessToken]}")
    response = data.to_h
    social_account = Social_account.find_by_provider_id response["id"]
    if social_account
      user = social_account.user
      sign_in user
    else
      user = User.new(email: response["email"], password: Settings.password_default)
      if user.save
        Social_account.create(provider: "facebook", provider_id: response["id"], user_id: user.id)
        sign_in user
      else
        flash[:danger] = t "controller.sessions.login_error"
      end
    end
    redirect_to root_path
  end
end
