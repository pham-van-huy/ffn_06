class TeamsController < ApplicationController
  def index
    @teams = Team.includes(:players, :matchs_one, :matchs_two)
                 .desc.paginate(page: params[:page], per_page: Settings.paginate_teams)
  end
end
