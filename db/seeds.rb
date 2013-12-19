default_users = []

# Generage 8 random users
(0..7).each do |i|
  default_users << {
      linkedin_id: i<<50,
      is_admin: 0,
      name: Forgery(:name).full_name,
      email: Forgery(:internet).email_address
  }
end

default_users.each do |userData|
  user = User.create!(userData)
end

# Generate 10 random posts for each user
default_posts = []
default_comments = []

(0..10).each do |i|
  User.all.each do |user|
    post = Post.create!({
        user_id: user.id,
        title: Forgery(:lorem_ipsum).words(5, options={
            random: true
        }).titleize,
        content: Forgery(:lorem_ipsum).words(100, options={
            random: true
        }).capitalize,
        created_on: Time.now - rand(2400.hours)
    })

    post.post_comments.create!({
        user_id: j,
        content: "This is my comment!",
        created_on: Time.now
    })
  end
end

default_posts.each do |post|
  Post.create!(post)
end

default_comments.each do |comment|
  PostComment.create!(comment)
end

# Create some tags
tags = []
(0...15).each do
  tags << Forgery(:lorem_ipsum).words(2, options={random: true}).titleize
end

i = 0
Post.all.each do |post|
  # Give each post random tags
  (0..3).each do
    post.post_tags.create({tag: tags[i]})
    i = (i + 1) % tags.length
  end
end
