# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "test@test.com", password_digest:"testtest")
User.create(email: "aa@aa.com", password_digest:"testtest")
User.create(email: "bb@bb.com", password_digest:"testtest")
User.create(email: "cc@cc.com", password_digest:"testtest")
User.create(email: "dd@dd.com", password_digest:"testtest")

Question.create(title:"test1", content:"test_content1", like:0, user_id:1,  anonymous:true, solved: true)
Question.create(title:"test2", content:"test_content2", like:100, user_id:1, anonymous:false, solved: false)
Question.create(title:"test3", content:"test_content3", like:0, user_id:2, anonymous:true, solved: true)
Question.create(title:"test4", content:"test_content4", like:20, user_id:3, anonymous:false, solved: false)
Question.create(title:"test5", content:"test_content5", like:0, user_id:4, anonymous:true, solved: true)

Answer.create(user_id: 2, question_id: 1, content: "test", like: 0, anonymous: false)
Answer.create(user_id: 3, question_id: 1, content: "test", like: 0, anonymous: true)
Answer.create(user_id: 4, question_id: 2, content: "test", like: 0, anonymous: false)
Answer.create(user_id: 1, question_id: 3, content: "test", like: 0, anonymous: true)
Answer.create(user_id: 5, question_id: 1, content: "test", like: 0, anonymous: false)
Answer.create(user_id: 1, question_id: 1, content: "test", like: 0, anonymous: true)

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
