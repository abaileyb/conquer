class EventsController < ApplicationController

	def index
		@events = Event.all
	end


	def joined
		@user = current_user
		@events = @user.events
	end

	def show
		@event = Event.find(params[:id])
		@guests = @event.users
		@hash = Gmaps4rails.build_markers(@event) do |event, marker|
  			marker.lat event.latitude
  			marker.lng event.longitude
		end
		@uncompleted_tasks = @event.tasks.where(completed: false)
		@completed_tasks = @event.tasks.where(completed: true)
	end

	def new
		@event = Event.new
		@event.host_id = current_user.id
	end

	def create
		@event = Event.new(events_params)
		@event.host_id = current_user.id

		if @event.save
			redirect_to events_path
		else
			render 'new'
		end
	end


	def add_guest
  		event = Event.find(params[:id])
	  	guest = User.find(params[:user_id]) 

  		event.users << guest unless event.users.include?(guest) # Make sure there are no duplicates in the join table

  		redirect_to event_path(event) # change this to whatever route you like
	end

	private
	def events_params
		params.require(:event).permit(:name, :description, :address, :date, :host_id)
	end
end
