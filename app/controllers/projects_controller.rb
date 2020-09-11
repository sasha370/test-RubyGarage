class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end


  private

  def set_project
    params.require(:project).permit(:name)
  end
end