# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
['Admin', 'Broker', 'Buyer'].each do |role|
    Role.find_or_create_by({name: role})
end

# User.create!(
#     first_name: 'Tom',
#     last_name: 'Reid',
#     email: ENV['ADMIN_EMAIL'],
#     password: ENV['ADMIN_PASSWORD'],
#     role_id: 1)

User.create!([
    { first_name: 'Tom', last_name: 'Reid', email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PASSWORD'], role_id: 1},
    { first_name: 'Jane', last_name: 'Doe', email: 'janedoe@email.com', password: '123qwe', role_id: 2 },
    { first_name: 'Uncle', last_name: 'Sam', email: 'unclesam@email.com', password: '123qwe', role_id: 2, approved: true },
    { first_name: 'John', last_name: 'Doe', email: 'johndoe@email.com', password: '123qwe', role_id: 3 }
])