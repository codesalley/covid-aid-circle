# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

markers = [
  [-122.3402, 47.6093],
  [-122.3402, 47.6094],
  [-122.3403, 47.6094],
  [-122.3384, 47.6098],
  [-122.3389, 47.6095],
  [-122.3396, 47.6095],
  [-122.3379, 47.6097],
  [-122.3378, 47.6097],
  [-122.3396, 47.6091],
  [-122.3383, 47.6089],
  [-122.3379, 47.6093],
  [-122.3381, 47.6095],
  [-122.3378, 47.6095],
]
User.create(first_name: "code", last_name: "salley", activated: true, verified: true, codinates: [-122.3396, 47.6095], password: "testtest", password_confirmation: "testtest", phone_number: "123423456").save

markers.each_with_index do |mark, index|
  User.create(phone_number: "123123" + mark[1].to_s, address: "test add" + mark[1].to_s, first_name: "myfirst" + mark[1].to_s, last_name: "maylast1" + mark[1].to_s, activated: true, verified: true, codinates: mark.reverse, password: "password#{index}", password_confirmation: "password#{index}").save
end
