default_users = []

# Generage 8 random users
(0..7).each do |i|
  default_users << {
      id: i,
      linkedin_id: i<<50,
      is_admin: 0,
      name: Forgery(:name).full_name,
      email: Forgery(:internet).email_address
  }
end

default_users.each do |user|
  User.create!(user)
end

# Generate 10 random posts for each user
default_posts = []

(0..10).each do |i|
  (0..7).each do |j|
    default_posts << {
        user_id: j,
        title: Forgery(:lorem_ipsum).words(5, options={
            random: true
        }),
        content: Forgery(:lorem_ipsum).words(100, options={
            random: true
        }),
        created_on: Time.now - rand(2400.hours)
    }
  end
end

default_posts.each do |post|
  Post.create!(post)
end
