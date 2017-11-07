module Admin::MatchsHelper
  def get_total_coin_beted bets
    bets.sum {|bet| bet.coin}
  end

  def statistic_coin bets
    bets.sum {|bet| bet.result ? bet.coin : -bet.coin}
  end
end
