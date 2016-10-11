class TasksController < ApplicationController
  def home
  end

  def help
  end

  def new
  	@task=Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
    	redirect_to @task
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def index
     @tasks = Task.paginate(page: params[:page])
  end

  def open
   	 @tasks = Task.order(params[:sort]).where(status: 1).paginate(page: params[:page])
  end
   
  def done
   	 @tasks = Task.where(status: 2).paginate(page: params[:page])
  end

  def toggleStatus
   	@task = Task.find(params[:id])
   	@task.status = params[:status]
   	 if @task.save
    	redirect_to @task
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def download
	  @tasks = Task.order(:deadline)
	  respond_to do |format|
	  format.html
	  format.csv { send_data @tasks.as_csv }
	  format.xml { send_data @tasks.to_xml }
  end
  end

end
