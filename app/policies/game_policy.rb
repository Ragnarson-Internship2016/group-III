class GamePolicy < ApplicationPolicy
  def edit?
    event_participant?
  end

  def update?
    event_participant?
  end

  def destroy?
    event_participant?
  end
end
