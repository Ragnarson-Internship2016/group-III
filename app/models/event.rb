class Event < ApplicationRecord
  has_many :user_events
  has_many :users, through: :user_events
  has_one :owner_user_event, -> { merge(UserEvent.owner) }, class_name: "UserEvent"
  has_one :owner, through: :owner_user_event, source: :user

  validates :name, :description, :city, :address, :start_t, :end_t, presence: true
  validate :validate_time_params

  def owner_or_attender?(user)
    owner?(user) || attender?(user)
  end

  def owner?(user)
    user == owner
  end

  def attender?(user)
    users.include?(user)
  end

  private

  def validate_time_params
    return if start_t.nil? || end_t.nil?
    if start_t < DateTime.now
      errors.add(:start_t, "Date should not be in the past.")
    end

    if start_t > end_t
      errors.add(:end_t, "Event can't end before it starts.")
    end
  end
end
