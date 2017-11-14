class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include LeaguesHelper
  before_action :latest_news
  before_action :bet_of_user

  def bet_of_user
    if signed_in?
      @bets = current_user.bets.includes(match: [:teams_col_one, :teams_col_two])
                          .get_beted.limit(Settings.limit_last_bets)
    end
  end

  def latest_news
    @latest_news = New.includes(:comments).limit(Settings.limit_last_new)
  end
end
