# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new
user.username = 'admin'
user.password = 'admin'
user.email    = 'admin@sitename.com'
user.display_name = 'admin'
user.save

user.add_role :superadmin
