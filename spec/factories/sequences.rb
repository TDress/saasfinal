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

  sequence :linkedin_id do |n|
    (n * 9999).to_s
  end

  sequence :email do |n|
    "jdoe#{n}@internet.com"
  end

  sequence :name do |n|
    "John Doe #{n}"
  end
end
