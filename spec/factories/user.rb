FactoryGirl.define do
  sequence :linkedin_id do |n|
    (n * 9999).to_s
  end

  sequence :email do |n|
    "jdoe#{n}@internet.com"
  end

  sequence :name do |n|
    "John Doe #{n}"
  end

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
  end
end
