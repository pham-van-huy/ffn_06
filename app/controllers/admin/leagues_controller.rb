class Admin::LeaguesController < ApplicationController
  before_action :valid_league, only: [:update, :destroy]
  before_action :check_admin
  def home_admin
    render :home_admin
  end

  def index
    @leagues = League.desc.includes(:country, :continent, matchs: [stadium: [:country]])
                     .paginate(page: params[:page], per_page: Settings.per_page_default)
  end

  def edit
    @league = League.includes(:country, :continent).find_by_id(params[:id])
    unless @league
      flag[:danger] = t "admin.leagues.edit.not_found"
      redirect_to admin_leagues_path
    end
  end

  def update
    @league.update_attributes! league_params
    flash[:success] = t "admin.leagues.edit.update_success"
    redirect_to admin_leagues_path
  rescue
    flash[:danger] = t "admin.leagues.edit.update_fail"
    render :edit
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new league_params
    if @league.save
      flash[:succes] = t "admin.leagues.new.create_success"
      redirect_to admin_leagues_path
    else
      flash[:danger] = t "admin.leagues.new.create_fail"
      render :new
    end
  end

  def destroy
    if @league.destroy
      flash[:succes] = t "admin.leagues.delete.delete_success"
    else
      flash[:danger] = t "admin.leagues.delete.delete_fail"
    end
    redirect_to admin_leagues_path
  end

  private
  def league_params
    params.require(:league).permit :logo, :name, :introduction, :continent_id, :logo, :time, :country_id
  end

  def valid_league
    @league = League.find_by_id(params[:id])
    unless @league
      flag[:danger] = t "admin.leagues.edit.not_found"
      redirect_to admin_leagues_path
    end
  end
  def check_admin
    redirect_to root_path unless logged_in? && current_user.role == "admin"
  end
end
