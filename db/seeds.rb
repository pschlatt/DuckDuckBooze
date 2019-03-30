# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#user types: 0 - visitor, 1 - registered, 2 - merchant, 3 - admin

#two visitors
@user_01 = User.create(role: 0, enable_disable: 0, name: "Tommy Shopper", street: "123 Busy Way", city: "Denver", state: "CO", zip: "80222", email: "tommy@gmail.com", password: "abcd1234")
@user_02 = User.create(role: 0, enable_disable: 0, name: "Lance Looker", street: "52 S Street", city: "Denver", state: "CO", zip: "80222", email: "lance@gmail.com", password: "zxywvut21")

#seven users(shoppers)
@user_11 = User.create(role: 1, enable_disable: 0, name: "Sally Shopper", street: "123 Busy Way", city: "Denver", state: "CO", zip: "80222", email: "sally@gmail.com", password: "12345678")
@user_12 = User.create(role: 1, enable_disable: 0, name: "Sam Spender", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "sam@gmail.com", password: "password")
@user_13 = User.create(role: 1, enable_disable: 0, name: "Bill Jones", street: "2 Cole Ave", city: "Lakewood", state: "CO", zip: "80228", email: "bill@gmail.com", password: "yolo1234")
@user_14 = User.create(role: 1, enable_disable: 0, name: "Bobby Buyer", street: "1 Way Too Busy", city: "Los Angeles", state: "CA", zip: "90210", email: "bobby@gmail.com", password: "yolo1234")
@user_15 = User.create(role: 1, enable_disable: 0, name: "Betty Buyer", street: "1 Way Too Busy", city: "Los Angeles", state: "CA", zip: "90210", email: "betty@gmail.com", password: "yolo1234")
@user_16 = User.create(role: 1, enable_disable: 0, name: "Paul Purchaser", street: "60 Stories Too Many", city: "Seattle", state: "WA", zip: "98315", email: "paul@gmail.com", password: "password")

#five merchants
@user_21 = User.create(role: 2, enable_disable: 0, name: "Mike Merchant", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "mike@gmail.com", password: "password")
@user_22 = User.create(role: 2, enable_disable: 0, name: "Pam Pusher", street: "2 Cole Ave", city: "Lakewood", state: "CO", zip: "80228", email: "pam@gmail.com", password: "yolo1234")
@user_23 = User.create(role: 2, enable_disable: 0, name: "Dealing Doug", street: "1 Way Too Busy", city: "Los Angeles", state: "CA", zip: "90210", email: "doug@gmail.com", password: "yolo1234")
@user_24 = User.create(role: 2, enable_disable: 0, name: "Carl Carsalesman", street: "1 Way Too Busy", city: "Los Angeles", state: "CA", zip: "90210", email: "carl@gmail.com", password: "yolo1234")
@user_25 = User.create(role: 2, enable_disable: 0, name: "Steve Seller", street: "60 Stories Too Many", city: "Seattle", state: "WA", zip: "98315", email: "steve@gmail.com", password: "password")

#two admins
@user_31 = User.create(role: 3, enable_disable: 0, name: "Aaron Admin", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "aaron@gmail.com", password: "password")
@user_32 = User.create(role: 3, enable_disable: 0, name: "Otis Overseer", street: "2 Cole Ave", city: "Lakewood", state: "CO", zip: "80228", email: "otis@gmail.com", password: "secure123")
