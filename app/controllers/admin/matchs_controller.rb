class Admin::MatchsController < ApplicationController
  before_action :get_league
  before_action :check_admin
  def new
    @match = Match.new
  end

  def index
    @matchs = @league.matchs.includes(:bets, :teams_col_one, :teams_col_two, :stadium)
      .paginate(page: params[:page], per_page: Settings.per_page_default)
  end

  def create
    match = @league.matchs.build get_params
    if match.save
      flash[:success] = t "admin.matchs.new.create_success"
      redirect_to new_admin_league_match_path @league
      Match.delay(run_at: match.end_time).update_match_bet match
    else
      flash[:success] = t "admin.matchs.new.create_fail"
      render :new
    end
  end

  private
  def get_league
    @league = League.find_by_id params[:league_id]
    unless @league
      flag[:danger] = t "admin.leagues.edit.not_found"
      redirect_to admin_leagues_path
    end
    @stadiums = Stadium.get_by_country @league.country_id
  end
  def get_params
    data = params.require(:match).permit(:team1_id,
        :team2_id, :team1_goal, :team2_goal, :stadium_id,
        :startdate, :starttime, :enddate, :endtime)
    data[:start_time] = params[:match][:startdate] + " " + params[:match][:starttime]
    data[:end_time] = params[:match][:enddate] + " " + params[:match][:endtime]
    data.delete("startdate")
    data.delete("starttime")
    data.delete("enddate")
    data.delete("endtime")
    data
  end
  def check_admin
    redirect_to root_path unless logged_in? && current_user.role == "admin"
  end
end
