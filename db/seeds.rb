# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "test@test.com", password_digest:"testtest")

Tag.create(name: "testTag1")
Tag.create(name: "testTag2")
Tag.create(name: "testTag3")
Tag.create(name: "testTag4")
Tag.create(name: "testTag5")

Tagging.create(question_id: 1, tag_id: 1)
Tagging.create(question_id: 2, tag_id: 2)
Tagging.create(question_id: 3, tag_id: 3)
Tagging.create(question_id: 4, tag_id: 4)
Tagging.create(question_id: 1, tag_id: 2)
