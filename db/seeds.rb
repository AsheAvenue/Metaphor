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

role = Role.new
role.name = 'admin'
role.key = 'admin'
role.save

user_role = UserRole.new
user_role.user_id = user.id
user_role.role_id = role.id
user_role.save
