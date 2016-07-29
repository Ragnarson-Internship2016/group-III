class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_event
  before_action :set_game, except: [:search, :new, :create]

  def show
  end

  def new
    authorize @event, :event_host?
    @game = @event.games.new
  end

  def create
    authorize @event, :event_host?
    @game = @event.games.new(game_params)

    if @game.save
      redirect_to @event, notice: 'Game was successfully added.'
    else
      render :new
    end
  end

  def edit
    authorize @game
  end

  def update
    authorize @game

    if @game.update(game_params)
      redirect_to @event, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @game
    @game.destroy
    redirect_to @event, notice: 'Game was successfully removed.'
  end

  def search
    authorize @event, :event_host?
    @found_games = Game::Search.call(params[:board_game_name])
    respond_to do |format|
      format.js { render "game_search_results" }
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name, :description, :min_players, :max_players)
  end
end
