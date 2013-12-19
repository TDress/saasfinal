FactoryGirl.define do
  factory :post do
    title
    content
    created_on
    user

    factory :post_with_comments do
      ignore do
        comments_count 2
      end

      after(:create) do |post, evaluator|
        FactoryGirl.create_list(:post_comment, evaluator.comments_count, post: post, user: create(:user))
      end
    end
  end
end
