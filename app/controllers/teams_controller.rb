class TeamsController < ApplicationController
  def index
    @teams = Team.includes(:matchs_one, :matchs_two, players: [:country])
                 .desc.paginate(page: params[:page], per_page: Settings.paginate_teams)
  end
end
