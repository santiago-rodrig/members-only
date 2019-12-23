# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Post.delete_all

User.create!([
  { name: 'john',
    email: 'john@example.com',
    password: 'secret',
    password_confirmation: 'secret'
  },
  { name: 'jen',
    email: 'jen@example.com',
    password: 'secret',
    password_confirmation: 'secret',
    premium: true
  }
])

User.find_by(name: 'john').posts.build(
  title: 'Secrets about Jen',
  body: 'Bla Bla Bla Secret here Bla'
).save

User.find_by(name: 'jen').posts.build(
  title: 'Secrets about John',
  body: 'Bla Bla Bla Secret here Bla'
).save
