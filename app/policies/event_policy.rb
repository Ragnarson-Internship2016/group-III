class EventPolicy < ApplicationPolicy
  def edit?
    unless eventuser.nil?
      eventuser.owner?
    end
  end

  def update?
    unless eventuser.nil?
      eventuser.owner?
    end
  end

  def destroy?
    unless eventuser.nil?
      eventuser.owner?
    end
  end

  private

  def eventuser
    return nil unless user
    UserEvent.find_by(user_id: user.id, event_id: record.id)
  end
end
