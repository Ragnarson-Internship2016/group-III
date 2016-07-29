FactoryGirl.define do
  factory :event do
    name "Dungeon Games"
    description "We are going to have so much fun playing games!"
    city "ert"
    address "erter"
    start_t DateTime.parse("09/08/2016 17:00")
    end_t DateTime.parse("09/08/2016 18:00")
  end
end
