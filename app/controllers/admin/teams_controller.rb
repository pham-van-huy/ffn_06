class Admin::TeamsController < ApplicationController
  def index
    @teams = Team.includes(:players).desc.paginate(page: params[:page], per_page: Settings.per_page_new_admin)
  end

  def new
    @team = Team.new
    binding.pry
  end

  def create
    team = Team.new team_params
    if team.save
      flash[:success] = t "admin.matchs.new.create_success"
      redirect_to admin_teams_path
    else
      flash[:danger] = t "admin.matchs.new.create_fail"
      render :new
    end
  end

  private
  def team_params
    params.require(:team).permit :name, :description, :logo, :country_id
  end
end
