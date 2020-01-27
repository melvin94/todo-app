class TasksController < ApplicationController
    def index
        @tasks = Task.all
        if params[:show] == "complete"
            @tasks = @tasks.done()
        elsif params[:show] == "incomplete"
            @tasks = @tasks.notdone()
        end
    end

    def show
        @task = Task.find(params[:id])
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.create(task_params)
        if @task.save
            redirect_to tasks_path
        else
            render 'new' 
        end
    end

    def edit
        @task = Task.find(params[:id])
        if params[:toggle] == "true"
            @task.done = !@task.done
            @task.update(done: @task.done)
            redirect_to tasks_path
        end
    end

    def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
            redirect_to tasks_path
        else
            render 'edit'
        end
    end

    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        redirect_to tasks_path
    end

    private
    def task_params
        params.require(:task).permit(:task,:done)
    end
end
