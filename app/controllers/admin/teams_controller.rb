class Admin::TeamsController < ApplicationController
  before_action :get_team, only: [:destroy, :edit, :update]
  before_action :check_admin
  before_action :get_country, only: [:new, :edit]

  def index
    @teams = Team.includes(:players).desc.paginate(page: params[:page], per_page: Settings.per_page_new_admin)
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new team_params
    if @team.save
      flash[:success] = t "admin.teams.new.create_success"
      redirect_to admin_teams_path
    else
      flash[:danger] = t "admin.teams.new.create_fail"
      render :new
    end
  end

  def edit; end

  def update
    @team.update_attributes! team_params
    flash[:success] = t "admin.leagues.edit.update_success"
    redirect_to admin_teams_path
  rescue
    flash[:danger] = t "admin.leagues.edit.update_fail"
    render :edit
  end

  def destroy
    if @team.destroy
      flash[:success] = t "admin.teams.new.delete_success"
    else
      flash[:danger] = t "admin.teams.new.delete_fail"
    end
    redirect_to admin_teams_path
  end

  private
  def team_params
    params.require(:team).permit :name, :description, :logo, :country_id
  end

  def get_team
    @team = Team.find_by_id params[:id]
    unless @team
      flash[:danger] = t "admin.teams.new.not_found"
      redirect_to admin_teams_path
    end
  end

  def check_admin
    redirect_to root_path unless signed_in? && current_user.admin?
  end

  def get_country
    @countrys = Country.all
  end
end
