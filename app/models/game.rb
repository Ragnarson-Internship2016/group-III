class Game < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }
  validates :min_players, presence: true, numericality: { greater_than: 0 }
  validates :max_players, presence: true, numericality: { less_than: 100 }
  validate :min_max_players

  def min_max_players
    return unless min_players && max_players
    errors.add(:max_players, 'Maximum number of players must be greater or equal to mininum number of players') if max_players < min_players
  end
end
