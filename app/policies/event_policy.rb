class EventPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def edit?
    event_host?
  end

  def update?
    event_host?
  end

  def destroy?
    event_host?
  end

  private

  def event_host?
    user == event.user
  end
end
