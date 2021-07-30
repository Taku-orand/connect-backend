class EventsController < ApplicationController
  def index
    @events = Event.joins(:user).select('events.*, users.id as user_id, users.name as user_name').order(created_at: "DESC")
    if @events
      render json: {get_events: true, events: @events}
    else
      render json: {get_event: false}
    end
  end

  def create
    @event = current_user.events.new(events_params)
    if @event.save
      render json: {create_event: true}
    else
      render json: {create_event: false}
    end
  end

  def edit
    
  end
  
  private

  def events_params
    params.require(:event).permit(:title, :content)
  end 
end
