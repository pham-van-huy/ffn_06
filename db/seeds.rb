User.create!(
  email: "admin@gmail.com",
  role: true,
  password: "123123",
  coin: 1000)

19.times do |n|
  name = Faker::Name.unique.name
  email = "email" + n.to_s + "@example.com"
  password = "123123"

  User.create!(
    email: email,
    password: password,
    coin: Faker::Number.between(0, 500)
  )
end

50.times do |n|
  New.create!(
    user_id: 1,
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph(80),
    count_comment: Faker::Number.between(0, 6),
    represent_image: ""
  )
end

New.all.each do |n|
  n.count_comment.times do |t|
    n.comments.create!(
      user_id: rand(1..20),
      content: Faker::Lorem.sentence
    )
  end
end

["Asia", "Africa", "North America", "South America", "Europe", "Australia"].each do |el|
  Continent.create!(
    name: el,
    logo: "image_default.jpg"
  )
end

Continent.all.each do |n|
  4.times do |t|
    n.countries.create!(
      name: Faker::Address.country,
      logo: "image_default.jpg"
    )
  end
end

10.times do |n|
  Team.create!(
    country_id: rand(1..24),
    name: Faker::Name.unique.name,
    description: Faker::Lorem.paragraph(3),
    logo: "image_default.jpg"
  )
end

Continent.all.each do |n|
  rand(1..2).times do |t|
    League.create!(
      continent_id: n.id,
      country_id: n.countries[rand(0..3)].id,
      name: Faker::Name.unique.name,
      time: Faker::Date.between(1.month.ago, 3.month.from_now),
      introduction: Faker::Lorem.paragraph(3),
      logo: nil
    )
  end
end

Country.all.each do |n|
  rand(1..2).times do |t|
    Stadium.create!(
      country_id: n.id,
      name: Faker::Name.unique.name,
      adress: Faker::Address.city,
      introduction: Faker::Lorem.paragraph(3)
    )
  end
end

10.times do |n|
  team1_id = rand(1..10)
  team2_id = Team.where("id != #{team1_id}")[rand(0..8)].id
  league = League.all()[rand(1..6)]
  start_time = Faker::Time.between(league.time, league.time + 25.days)
  end_time = start_time + 105.minutes
  Match.create!(
    team1_id: team1_id,
    team2_id: team2_id,
    stadium_id: Stadium.all[rand(1..24)].id,
    league_id: league.id,
    start_time: start_time,
    end_time: end_time,
    team1_goal: rand(0..5),
    team2_goal: rand(0..5)
  )
end

User.all.each do |n|
  rand(0..3).times do |t|
    Bet.create!(
      user_id: n.id,
      match_id: rand(1..10),
      team1_goal: rand(0..5),
      team2_goal: rand(0..5),
      coin: rand(1..n.coin),
      result: [true, false][rand(0..1)]
    )
  end
end

Team.all.each do |n|
  rand(5..10).times do |t|
    Player.create!(
      team_id: n.id,
      country_id: Country.all[rand(0..23)].id,
      name: Faker::Name.unique.name,
      birthday: Faker::Date.forward(rand(30..60)),
      introduction: Faker::Lorem.paragraph(3),
      avatar: "image_default.jpg"
    )
  end
end
