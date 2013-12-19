FactoryGirl.define do
  factory :user do
    name
    email
    linkedin_id

    factory :user_with_posts do
      ignore do
        posts_count 5
      end

      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:post, evaluator.posts_count, user: user)
      end
    end

    factory :user_with_posts_and_comments do
      ignore do
        posts_count 5
      end

      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:post_with_comments, evaluator.posts_count, user: user)
      end
    end
  end
end
