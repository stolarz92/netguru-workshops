# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'ffaker'
def create_admin
  User.create!(
      email: 'admin@example.com',
      firstname: 'admin',
      lastname: 'lastname',
      password: 'password',
      password_confirmation: 'password',
      admin: true
  )
end

def create_users
  5.times do
    email = Faker::Internet.email
    firstname = Faker::Name.first_name
    lastname = Faker::Name.last_name
    password = 'password'
    password_confirmation = 'password'

    User.create!(
        email: email,
        firstname: firstname,
        lastname: lastname,
        password: password,
        password_confirmation: password_confirmation
    )
  end
end

def create_category
  Category.create(name: 'Misc')
end

def create_products
  category = Category.first
  users = User.all[1..-1]

  users.each do |user|
    5.times do
      title = Faker::Product.product
      description = Faker::Lorem.paragraph
      price = [10,20,35,50,100].sample

      category.products.create(
          title: title,
          description: description,
          price: price,
          category_id: category,
          user_id: user.id
      )
    end
  end
end

def create_reviews
  users = User.all

  users.each do |user|
    5.times do
      rating = (1..5).to_a.sample
      content = Faker::Lorem.sentence(5)
      product_id = (1..25).to_a.sample

      user.reviews.create!(
          content: content,
          rating: rating,
          product_id: product_id,
      )
    end
  end
end

create_admin
create_users
create_category
create_products
create_reviews

