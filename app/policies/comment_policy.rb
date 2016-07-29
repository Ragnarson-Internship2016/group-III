class CommentPolicy < ApplicationPolicy

  def create?
    commenter?
  end

  private

  def commenter?
    return false unless user
    UserEvent.find_by(user_id: user.id, event_id: record.commentable.id)
  end
end
