require 'bgg'

class Game::Search
  def self.call(bord_game_query)
    return if bord_game_query.nil? || bord_game_query.empty?
    games_id = search_id(bord_game_query)
    games_id ||= search_ids(bord_game_query)
    fetch_games_info(games_id)
  end

  def self.search_id(bord_game_query)
    begin
      game = Bgg::Search.exact_query(bord_game_query)
    rescue
      return
    end
    return [game.id] if game
  end

  def self.search_ids(bord_game_query)
    Bgg::Search.query(bord_game_query).map(&:id)
  end

  def self.fetch_games_info(games_id)
    games_info = []
    games_id.each do |game_id|
      begin
        game_info = Bgg::Game.find_by_id(game_id)
      rescue
        next
      end
      games_info << Game.new(
        name: game_info.name,
        description: game_info.description,
        min_players: game_info.min_players,
        max_players: game_info.max_players
      )
    end
    games_info
  end
end
