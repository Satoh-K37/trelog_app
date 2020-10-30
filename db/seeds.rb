# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env == "development"
  100.times do |i|
    user = User.find(1)
    user.tasks.create!(title: "test#{i + 1}", weight: "10", rep: "10", set_count: "2")
  end

  5.times do |i|
    Title.create!(title_name: "筋トレ#{i + 1}")
  end

end