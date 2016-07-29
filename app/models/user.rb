class User < ApplicationRecord
  has_many :user_events
  has_many :events, through: :user_events
  has_many :owned_events, -> { where "user_events.owner": true }, through: :user_events, source: :event
  has_many :participated_events, -> { where "user_events.owner": false }, through: :user_events, source: :event
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, :surname, :city, presence: true
end
