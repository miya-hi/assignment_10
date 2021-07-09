# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create(name: "m", email: "h@email.com", password: "123456", admin: true )

10.times do |n|
  email_maker = "abc#{n}@example.com",
  User.create!(name: "name",
               email: email_maker,
               password: "password",
               admin: false
               )
end
10.times do |n|
  name = "タスク#{n}"
  description = "内容#{n}"
  deadline = DateTime.new(2021,5, rand(1..30))
  status = '着手中'
  priority = rand(0..2)
  user_id = rand(0..50)
  Task.create!(name: name,
               description: description,
               deadline: deadline,
               status: status,
               priority: priority,
               user_id: user_id
               )
end
Label.create([
  { name: '趣味' },
  { name: '仕事' },
  { name: '急ぎ'},
  { name: '学校'},
  { name: '音楽'},
  { name: '料理'},
  { name: '運動'},
  { name: 'ダイエット'},
  { name: '息抜き'},
  { name: '映画'},
  ])
