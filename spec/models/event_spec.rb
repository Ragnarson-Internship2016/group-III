require 'rails_helper'

RSpec.describe Event, type: :model do
  context "validates presence of params" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:start_t) }
    it { is_expected.to validate_presence_of(:end_t) }
    it { is_expected.to validate_presence_of(:user_id) }
  end

  context "validates time params" do
    let(:user) { User.create!(name: "Username", surname: "Usersurname", city: "Lodz", email: "a@a.a", password: "password")}

    let(:valid_attributes) {
      {
        name: "Dungeon Games",
        description: "We are going to have so much fun playing games!",
        city: "Lodz",
        address: "Piotrkowska 217",
        user_id: user.id
      }
    }

    it "raises an error if start time is lower than present time" do
      event = Event.new(valid_attributes.merge({
        start_t: DateTime.now - 1,
        end_t: DateTime.parse("09/08/2016 22:00"),
      }))
      expect(event).to_not be_valid
    end

    it "raises an error if end time is lower than start time" do
      event = Event.new(valid_attributes.merge({
        start_t: DateTime.now + 20,
        end_t: DateTime.now + 10,
      }))
      expect(event).to_not be_valid
    end
  end
end
