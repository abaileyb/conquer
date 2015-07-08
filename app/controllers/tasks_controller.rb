class TasksController < ApplicationController
	def show
		@task = Task.find(params[:id])
		@event = @task.event
	end

	def new
		@task = Task.new
		@event = Event.find(params[:event_id])
	end

	def create
		@event = Event.find(params[:event_id])

		@task = @event.tasks.create(task_params)
		if @task.save
			redirect_to event_path(@event)
		else
			render 'new'
		end
	end

	def index
		@user = current_user
		@tasks = @user.tasks
	end



	def add_task
  		task = Task.find(params[:id])

	  	guest = User.find(params[:user_id]) 

  		task.user_id = guest.id
  		task.save

  		redirect_to event_task_path(task.event, task) # change this to whatever route you like
	end

	def complete_task
		task = Task.find(params[:id])
		task.completed = true
		task.save

		redirect_to event_task_path(task.event, task)
	end
	
	private
	def task_params
		params.require(:task).permit(:name, :description)
	end
end
