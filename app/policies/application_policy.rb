class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def game_host?
    record.event.users.includes(user)
  end

  def event_host?
    return false unless user
    UserEvent.find_by(user_id: user.id, event_id: record.id, owner: true)
  end
end

