50.times do
  Project.create title: Faker::Lorem.word,
                  description: Faker::Lorem.sentence,
                  due_date: Faker::Time.between(DateTime.now - 100, DateTime.now)
end
