class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def event_participant?
    return false unless user
    record.event.users.include?(user)
  end

  def event_host?
    return false unless user
    UserEvent.find_by(user_id: user.id, event_id: record.id, owner: true)
  end
end

