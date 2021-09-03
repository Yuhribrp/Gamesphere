# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'cgi'

# communities
puts "---------------Seeding Communities Started---------------"

Post.delete_all
Community.delete_all
User.delete_all

lea_of_leg = Community.create!(title: "League of Legends")

# Faker::Game.title
25.times do
  Community.create!(title: Faker::Game.title)
  puts "seeded with -- #{Community.last.title}"
  uri = CGI.escape(Community.last.title)
  # Community.last.img_url="https://loremflickr.com/320/240/#{uri}"
  Community.update((Community.last.id), img_url: "https://loremflickr.com/320/240/#{uri}")
  puts "cs::uri=#{uri}"
  puts "cs::img_url=#{Community.last.img_url}"
end
puts "------------- Seeding communities completed -------------------"


puts "_______________________ Seeding User _________________________"
ju = User.new(email: "ju@lewagon.com", password: "123456", username: "Juquinha")
ju.save


puts "------------- Seeding users -------------------"
player_one = User.new(
  email: "player_one@icloud.com",
  password: "abc123",
  username: "parzival",
  full_name: "Wade Watts",
  language: "english",
  location: "Columbus, Ohio",
  age: 27
)
# player_one.skip_before_action!
player_one.save!

players = []
evaluations = []

25.times do
  players << User.new(
    email: Faker::Internet.email,
    # password: Faker::Alphanumeric.alphanumeric(number: 10),
    password: "acb123",
    username: "#{Faker::Hacker.verb}_#{Faker::Hacker.noun}",
    full_name: Faker::Name.unique.name,
    language: Faker::Nation.language,
    location: Faker::Nation.capital_city,
    age: rand(1..135)
  )
  players.last.save!
  puts "...added #{players.last.username}, #{players.last.full_name}"


  rand(3..10).times do
    puts "-----seeding evals------"
    evaluations << Evaluation.new(
      communicability: rand(1..5),
      tilt_resistance: rand(1..5),
      manners: rand(1..5),
      sociability: rand(1..5),
      leadership: rand(1..5),
      hotness: rand(1..5),
      user_id: players.last.id
    )
    evaluations.last.save!
    puts "player: #{players.last.username} has:
      c: #{evaluations.last.communicability}
      tr: #{evaluations.last.tilt_resistance}
      m: #{evaluations.last.manners}
      s: #{evaluations.last.sociability}
      l: #{evaluations.last.leadership}
      ht: #{evaluations.last.hotness} "
  end
end
puts "------------- Seeding users completed -------------------"


puts "------------- Seeding posts -------------------"
Post.create!(photo: "https://img.ibxk.com.br/2015/06/15/15150935995121.jpg?w=1120&h=420&mode=crop&scale=both", content: "Sou bicho brabo do Mario", like: 3, community_id: lea_of_leg.id)
puts "------------- Seeding posts completed -------------------"
