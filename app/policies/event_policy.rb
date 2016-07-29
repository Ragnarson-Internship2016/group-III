class EventPolicy < ApplicationPolicy
  def edit?
    event_host?
  end

  def update?
    event_host?
  end

  def destroy?
    event_host?
  end
end
