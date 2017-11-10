module LeaguesHelper
  def matched matchs
    matchs.select{|match| match.end_time.past?}
  end

  def bets_of_user bets
    bets.select{|bet| bet.user_id == current_user.id}
  end

  def check_result bet
    if bet.present?
      return "" if bet.result.nil?
      bet.result ? "bet-win" : "bet-lose"
    end
  end

  def valid_bet? match
    check_time = (match.start_time + Settings.valid_bet.minutes).future?
    logged_in? && current_user.coin > 0 && check_time
  end

  def ranking_in_leagues matchs
    team_col_one = matchs.group_by { |e| e[:team1_id] }
    team_col_two = matchs.group_by { |e| e[:team2_id] }
    teams = team_col_one.merge(team_col_two){ |k, one_value, two_value| [one_value, two_value] }
    team_score = teams.map do |key, match|
      if match.size > 1
        if key == match.first.first.team1_id
          {score: score_of_team(match, key), match: match, team: match.first.first.teams_col_one}
        else
          {score: score_of_team(match, key), match: match, team: match.first.first.teams_col_two}
        end
      else
        if key == match.first.team1_id
          {score: score_of_team(match, key), match: match, team: match.first.teams_col_one}
        else
          {score: score_of_team(match, key), match: match, team: match.first.teams_col_two}
        end
      end
    end
    team_score.sort! do |x, y|
      y[:score] <=> x[:score]
    end
    team_score
  end

  def score_of_team team, key
    score = 0
    team.each do |e|
      if team.size >= 2
        if key == e.first.team1_id
          score += e.first.team1_goal == e.first.team2_goal ? 1 : e.first.team1_goal > e.first.team2_goal ? 3 : 0
        else
          score += e.first.team1_goal == e.first.team2_goal ? 1 : e.first.team1_goal > e.first.team2_goal ? 0 : 3
        end
      else
        if key == e.team1_id
          score += e.team1_goal == e.team2_goal ? 1 : e.team1_goal > e.team2_goal ? 3 : 0
        else
          score += e.team1_goal == e.team2_goal ? 1 : e.team1_goal > e.team2_goal ? 0 : 3
        end
      end
    end
    score
  end

  def country_continent continent_id
    Country.get_by_continent continent_id
  end
end
