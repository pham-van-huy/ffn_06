FactoryBot.define do
  factory :league do
    name "UEFA Champions League"
    introduction "Paris Saint-Germain, Bayern München, Manchester City and Tottenham Hotspur are through"
    continent nil
    country nil
    time DateTime.now
  end
end
