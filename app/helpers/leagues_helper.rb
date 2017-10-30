module LeaguesHelper
  def matched matchs
    matchs.select{|match| match.end_time.past?}
  end
end
