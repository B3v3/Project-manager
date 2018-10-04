class PagesController < ApplicationController
  def home
    if current_user
      @user = current_user
      @projects = current_user.groups
      @tasks = current_user.tasks.where(status: false)
    end
  end
end
