default_users = [
  {:id => 0, :google_id => 5555555, :is_admin => 0,
    :name => 'John P', :email => 'john.professor@example.com'},
  {:id => 1, :google_id => 55555555, :is_admin => 0,
    :name => 'Joe Developer', :email => 'joe.developer@example.com'}
]

default_users.each do |user|
  User.create!(user)
end

default_posts = [
  {:user_id => 1, :title => 'First Job',
  	:content =>
  	"It wasn't until I had my first job with a small team that I realized it didn't matter what I knew how to do or what experience I had.  In a fast- paced work environment, what mattered was whether or not I could learn something new quickly, and if I could get things done."
  },
  {:user_id => 0, :title => 'Last Job',
  	:content =>
  	"I will be retiring soon, and after 40 years of experience in the field, I still feel that the most important moment of my career came when I was a fresh college graduate.  I felt like the least knowledgable, least experienced person in the company.  This was back when the C programming language had just been invented, and I knew nothing about it.  My boss handed me a thick book- the specs for one of our systems.  He said 'I want you to port this to C.  You'd better get a book.'  I struggled and struggled, accomplished the task, and for the next 40 years everything was easier."
  }
]

default_posts.each do |post|
  Post.create!(post)
end
