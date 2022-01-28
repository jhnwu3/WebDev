# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin.create(a_name: "test2", email: "test.2@osu.edu", password: "test2pass", created_at: Date.new(2020,11,28).to_time.to_i, updated_at: Date.new(2020,11,29).to_time.to_i)
# User.create(u_name: "user1", email: "user1@osu.edu", password: "pw", created_at: Date.today, updated_at: Date.today)
User.create({name: "user", email: "user@osu.edu", password: "pw"})