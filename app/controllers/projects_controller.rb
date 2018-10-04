class ProjectsController < ApplicationController
  before_action :logged_in?
  before_action :find_project, except: [:new, :create]
  before_action :authenticate_member, except: [:new, :create, :accept_invite]
  before_action :authenticate_owner, only: [:edit, :update, :destroy, :add_user]

  def show
    @tasks = @project.tasks
  end

  def new
    @project = Project.new
  end

  def create
    project = current_user.projects.build(project_params)
      if project.save
        flash[:success] = 'Your project has been created! Add some members now!'
        redirect_to project
      else
        render 'new'
      end
  end

  def edit
  end

  def send_invite
    ProjectMailer.project_invite(@project, params[:email]).deliver_now
    redirect_to @project
  end

  def update
    if @project.update_attributes(project_params)
      flash[:success] = "Your project has been updated!"
      redirect_to @project
    else
      render "edit"
    end
  end

  def destroy
    @project.destroy
    redirect_to root_path
  end

  private
    def find_project
      @project = Project.friendly.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :description)
    end
end
