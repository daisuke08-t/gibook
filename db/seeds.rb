# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(name:  "adminuser",
             email: "example@example.com",
             password:              "password0000",
             password_confirmation: "password0000",
             icon: nil, 
             content: nil,
             admin: true)