class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include LeaguesHelper
  before_action :ranking_team

  def ranking_team
    teams = Team.all
    teams.each do |e|
      e.score = ranking_score[e.id]
    end
    @teams_ranked = teams.sort{|x, y| y.score <=> x.score}
  end

  private
  def ranking_score
    teams = Team.includes(:matchs_one, :matchs_two)
    score_one = {}
    score_two = {}
    teams.each do |e|
      score_one[e.id] = evaluate e.matchs_one, true
      score_two[e.id] = evaluate e.matchs_two, false
    end
    score_one.merge!(score_two){|_k, o, n| o + n}
    score_one.sort_by{|_key, value| value}.to_h
  end

  def evaluate maths, is_one
    score = 0
    if is_one
      maths.each do |e|
        if e.team1_goal > e.team2_goal
          score += 3
        elsif e.team1_goal == e.team2_goal
          score += 1
        end
      end
    else
      maths.each do |e|
        if e.team1_goal < e.team2_goal
          score += 3
        elsif e.team1_goal == e.team2_goal
          score += 1
        end
      end
    end
    score
  end
end
