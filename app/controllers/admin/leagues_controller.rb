class Admin::LeaguesController < ApplicationController
  def home_admin
    render :home_admin
  end

  def index
    @leagues = League.desc.includes(:country, :continent, matchs: [stadium: [:country]])
                     .paginate(page: params[:page], per_page: Settings.per_page_default)
  end

  def new; end

  def create
    binding.pry
    new_league = League.new league_params
    if new_league.save
      flash[:succes] = t "admin.leagues.new.create_success"
      redirect_to admin_leagues_path
    else
      flash[:danger] = t "admin.leagues.new.create_fail"
      render :new
    end
  end

  private
  def league_params
    params.require(:league).permit(:logo, :name, :introduction, :continent_id, :logo, :time, :country_id)
  end
end
