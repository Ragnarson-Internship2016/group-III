class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @events = Event.all
  end

  def show
    @comments = @event.comments
    @comment = Comment.new
  end

  def new
    @event = current_user.events.new
  end

  def edit
    authorize @event
  end

  def create
    @event = current_user.owned_events.new(event_params)

    if @event.save
      UserEvent.create(user_id: current_user.id, event_id: @event.id, owner: true)
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @event
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to (events_path), notice: 'Event was successfully destroyed.'
  end

  def join
    @event = Event.find(params[:id])
    @join_event = UserEvent.create!(user_id: current_user.id, event: @event)

    if @join_event.persisted?
      redirect_to @event, notice: 'You successfully joined the event'
    else
      redirect_to @event, notice: 'There was an error while adding you to this event.'
    end
  end

  def leave
    @event = Event.find(params[:id])
    UserEvent.find_by(user_id: current_user, event: @event).destroy
    redirect_to @event, notice: 'You successfully left event.'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :city, :address, :start_t, :end_t)
  end
end
