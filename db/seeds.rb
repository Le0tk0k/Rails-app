User.create!(name:  "Admin User",
  email: "example@example.com",
  password:              "example",
  password_confirmation: "example",
  admin: true )

99.times do |n|
name  = "sample#{n+1}"
email = "example#{n+1}@example.com"
password = "example"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password, )
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }