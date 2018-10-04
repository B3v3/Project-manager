class TasksController < ApplicationController
  before_action :user_signed_in?
  before_action :find_project
  before_action :authenticate_member
  before_action :authenticate_owner, only: [:destroy, :create]
  before_action :find_task, except: [:create]

  def create
    task = @project.tasks.build(task_params)
    if task.save
      flash[:success] = 'Task has been added!'
    else
      flash[:danger] = 'Your task should have a better description'
    end
    redirect_to @project
  end

  def update_user
    @task.assign_user(current_user)
    redirect_to @project
  end

  def update_status
    @task.complete
    redirect_to @project
  end

  def destroy
    @task.destroy
    redirect_to @project
  end

  private
  def find_project
    @project = Project.friendly.find(params[:project_id])
  end

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description)
  end
end
