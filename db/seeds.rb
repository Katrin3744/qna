# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

questions = Question.create!([{title: 'Title1', body: 'Body1'},
                             {title: 'Title2', body: 'Body2'},
                             {title: 'Title3', body: 'Body3'}])
answers = Answer.create!([{body: 'body11', question: questions[0]},{body: 'body12', question: questions[0]},
                          {body: 'body21', question: questions[1]},{body: 'body22', question: questions[1]},
                          {body: 'body31', question: questions[2]},{body: 'body32', question: questions[2]}])