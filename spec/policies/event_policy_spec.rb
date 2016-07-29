require 'spec_helper'

RSpec.describe EventPolicy do
  subject { described_class }
  let(:event_host){ FactoryGirl.create(:user) }
  let(:other_user) { User.new(id: 1, name: "username", surname: "usersurname", city: "Lodz", email: "b@b.a", password: "password", confirmed_at: DateTime.now) }
  let(:event){ FactoryGirl.create(:event) }
  let!(:event_user) { UserEvent.new(user_id: event_host.id, event_id: event.id, owner: true).save }

  permissions :edit?, :update?, :destroy? do
    it "grants access if user is host of event" do
      expect(subject).to permit(event_host, event)
    end

    it "denies access if user is not host of event" do
      expect(subject).not_to permit(other_user, event)
    end
  end
end
