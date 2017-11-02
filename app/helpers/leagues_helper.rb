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
end
