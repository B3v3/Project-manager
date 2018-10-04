class MembershipsController < ApplicationController
before_action :logged_in?
before_action :set_user
before_action :set_project

  def create
    if @user && @project.invite_digest == (params[:auth_key])
      @project.add_member(@user)
      redirect_to @project
    end
  end

  private
  def set_user
    @user = current_user
  end

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end
end
