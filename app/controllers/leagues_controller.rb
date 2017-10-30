class LeaguesController < ApplicationController
  def index
    @leagues = League.desc.includes(:country, :continent, matchs: [stadium: [:country]])
                     .paginate(page: params[:page], per_page: Settings.per_page_default)
  end

  def show
    @league = League.includes(:country, :continent,
      matchs: [:teams_col_one, :teams_col_two, stadium: [:country]]).find_by_id params[:id]

    unless @league
      flash[:danger] = t "controller.leagues.not_found"
      redirect_to root_path
    end
    @match_size = @league.matchs.size
  end
end
