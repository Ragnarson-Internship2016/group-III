FactoryGirl.define do
  factory :user do
    name 'Lolo'
    surname 'Polo'
    city 'Lolopolo'
    email 'lolopolo@example.com'
    password 'lolopolo'
    confirmed_at DateTime.now
  end
end
