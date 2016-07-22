class Event < ApplicationRecord
  belongs_to :user

  validates :name, :description, :city, :address, :start_t, :end_t, :user_id, presence: true
  validate :validate_time_params

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
