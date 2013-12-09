FactoryGirl.define do
  sequence :title do |n|
    "Amazing Title #{n}"
  end

  sequence :content do |n|
    "This is amazing content #{n}. Lorem ipsum dolor sit amet."
  end

  sequence :created_on do |n|
    DateTime.ordinal(2013, (n%364)+1)
  end

  factory :post do
    title
    content
    created_on
    user
  end
end
