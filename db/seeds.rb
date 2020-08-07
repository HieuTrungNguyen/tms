User.create! name: "Hieu Trung Nguyen",
             email: "nguyentrunghieu3103@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             phone_number: "0123456789",
             address: "Gia Loc, Hai Duong",
             role: 1

50.times do |n|
  name         = Faker::Name.name
  email        = "example-#{n+1}@gmail.com"
  password     = "123456"
  phone_number = Faker::Number.leading_zero_number digits: 10
  address      = "Cam Giang, Hai Duong"
  User.create! name: name,
               email: email,
               password: password,
               password_confirmation: password,
               phone_number: phone_number,
               address: address,
               role: 0
end

20.times do
  name          = Faker::Lorem.word + " " + Faker::Lorem.word
  description   = Faker::Lorem.paragraph sentence_count: 10
  time_training = Faker::Number.number digits: 2
  Course.create! name: name,
                 description: description,
                 time_training: time_training
end

15.times do
  name        = Faker::Lorem.word + " " + Faker::Lorem.word
  description = Faker::Lorem.paragraph sentence_count: 4
  content     = Faker::Lorem.paragraph sentence_count: 10
  Subject.create! name: name,
                  description: description,
                  content: content
end

courses = Course.all
courses.each do |course|
  subjects = Subject.all.sample(rand(5..10))
  subjects.each do |subject|
    CourseSubject.create! course_id: course.id,
                          subject_id: subject.id,
                          status: "open"
  end
end

courses.each do |course|
  users = User.all.sample(rand(5..30))
  users.each do |user|
    UserCourse.create! user_id: user.id,
                       course_id: course.id,
                       status: "active",
                       date_join: Time.zone.now,
                       finished_at: Time.zone.parse('2020-08-31 23:59:59')
  end
end
