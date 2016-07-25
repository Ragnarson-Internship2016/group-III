require 'rails_helper'

RSpec.describe Game, type: :model do
  context "name" do
    it "exists" do
        is_expected.to validate_presence_of(:name)
    end

    it "is longer than 2" do
      is_expected.to validate_length_of(:name).is_at_least(2)
    end
  end

  context "min_players" do
    it "exists" do
      is_expected.to validate_presence_of(:min_players)
    end

    it "is above zero" do
      is_expected.to validate_numericality_of(:min_players).is_greater_than(0)
    end
  end

  context "max_players" do
    it "exists" do
      is_expected.to validate_presence_of(:max_players)
    end

    it "is less than 100" do
      is_expected.to validate_numericality_of(:max_players).is_less_than(100)
    end
  end

  context "#min_max_players" do
    subject(:game) { Game.new(name: "Test", min_players: 5,  max_players: 1) }

    it "doesn't allow max_players < min_players" do
      game.valid?
      expect(game.errors.added? :max_players, 'Maximum number of players must be greater or equal to mininum number of players').to be true
    end
  end
end
