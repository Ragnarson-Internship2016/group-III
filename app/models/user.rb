class User < ApplicationRecord
  has_many :events

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, :surname, :city, presence: true
end
