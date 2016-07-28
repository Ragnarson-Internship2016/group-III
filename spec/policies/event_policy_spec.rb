require 'spec_helper'

RSpec.describe EventPolicy do
  subject { described_class }
  let(:event_host) { User.new(name: "Hostname", surname: "Hostsurname", city: "Lodz", email: "a@a.a", password: "password", confirmed_at: DateTime.now) }
  let(:other_user) { User.new(name: "username", surname: "usersurname", city: "Lodz", email: "b@b.a", password: "password", confirmed_at: DateTime.now) }

  let(:event) { event_host.events.new(
    name: "Dungeon Games",
    description: "We are going to have so much fun playing games!",
    city: "ert",
    address: "erter",
    start_t: DateTime.parse("09/08/2016 17:00"),
    end_t: DateTime.parse("09/08/2016 18:00")
  ) }

  permissions :edit?, :update?, :destroy? do
    it "grants access if user is host of event" do
      expect(subject).to permit(event_host, event)
    end

    it "denies access if user is not host of event" do
      expect(subject).not_to permit(other_user, event)
    end
  end
end
