class EventsController < ApplicationController
  def index
    
  end

  def create
    @event = current_user.events.new(events_params)
    p @event
  end
  
  private

  def events_params
    params.require(:event).permit(:title, :content)
  end 
end
