class GamePolicy < ApplicationPolicy
  def edit?
    game_host?
  end

  def update?
    game_host?
  end

  def destroy?
    game_host?
  end
end