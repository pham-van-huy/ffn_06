class MatchsController < ApplicationController
  def show
    @match = Match.find_by_id params[:id]
    @match_one = match_of_team @match.teams_col_one
    @match_two = match_of_team @match.teams_col_two
    @vs = Match.where.not(id: @match.id).vs([@match.team1_id, @match.team2_id]).matched.team_limit.desc
  end

  private
  def match_of_team team
    matchs_one = team.matchs_one.includes(:teams_col_two).matched.desc.team_limit
    matchs_two = team.matchs_two.includes(:teams_col_one).matched.desc.team_limit
    match = matchs_one + matchs_two
    match.sort!{|x, y| y.start_time <=> x.start_time}
  end
end
