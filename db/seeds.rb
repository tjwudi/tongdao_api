# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: "Chicago" }, { name: "Copenhagen" }])
#   Mayor.create(name: "Emanuel", city: cities.first)


User.create([
  { id: 1, nickname: "JohnWu", encrypted_password: "abcabc", email: "webmaster@leapoahead.com",  last_login_time: DateTime.now },
  { id: 3, nickname: "BigTree", encrypted_password: "abcabc", email: "bigtree@leapoahead.com",  last_login_time: DateTime.now },
  { id: 2, nickname: "Sherry", encrypted_password: "abcabc", email: "lifeisgood@leapoahead.com" ,last_login_time: DateTime.now }
])

User.find(1).follow_user!(User.find(2))
User.find(1).follow_user!(User.find(3))

Project.create([
  { title: "nice project", category: "campus", school: "Tongji University", state: "wanting" },
  { title: "nice project 2", category: "campus", school: "Tongji University", state: "wanting" },
  { title: "nice project 3", category: "campus", school: "Tongji University", state: "wanting" },
  { title: "nice project 4", category: "campus", school: "Tongji University", state: "wanting" },
  { title: "nice project 5", category: "literature", school: "Tongji University", state: "wanting" },
  { title: "nice project 6", category: "literature", school: "Tongji University", state: "wanting" },
  { title: "nice project 7", category: "literature", school: "Tongji University", state: "wanting" }
])

Membership.create([
  { user_id: 1, project_id: 1, is_owner: false},
  { user_id: 1, project_id: 2, is_owner: true },
  { user_id: 1, project_id: 3, is_owner: true },
  { user_id: 1, project_id: 4, is_owner: true },
  { user_id: 1, project_id: 5, is_owner: false },
  { user_id: 1, project_id: 6, is_owner: false },
  { user_id: 1, project_id: 7, is_owner: false },
  { user_id: 2, project_id: 1, is_owner: true },
  { user_id: 2, project_id: 5, is_owner: true },
  { user_id: 2, project_id: 6, is_owner: true },
  { user_id: 2, project_id: 7, is_owner: true }
])

Tag.create([
  { name: "School" },
  { name: "Cooking" }
])

TagAttachment.create([
  { tag_id: 1, project_id: 1 },
  { tag_id: 1, project_id: 2 },
  { tag_id: 2, project_id: 1 }
])
