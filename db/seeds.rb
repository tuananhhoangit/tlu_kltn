User.create! name: "Admin", email: "admin@example.com",
  password: "123123", password_confirmation: "123123", is_admin: true

10.times do |n|
  name = Faker::Name.name
  email = "example#{n+1}@example.com"
  password = "123123"
  User.create! name: name, email: email, password: password,
    password_confirmation: password
end

users = User.order(:created_at).take 5
5.times do
  title = Faker::Lorem.sentence Settings.post.title_lorem_sentences
  content = Faker::Lorem.sentence Settings.post.content_lorem_sentences
  users.each {|user| user.posts.create! title: title, content: content}
end
