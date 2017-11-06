module Admin::MatchsHelper
  def get_total_coin_beted bets
    total = 0
    bets.each do |bet|
      total += bet.coin
    end
    total
  end

  def statistic_coin bets
    total = 0
    bets.each do |bet|
      if bet.result
        total -= bet.coin
      else
        total += bet.coin
      end
    end
    total
  end
end
