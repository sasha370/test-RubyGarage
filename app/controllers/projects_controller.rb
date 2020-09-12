class ProjectsController < ApplicationController
  before_action :set_project, only: [ :show, :edit, :update, :destroy]


  def index
    @projects = Project.all
    # @tasks = Task.all.where(project_id: @project)
  end

  def new
    @project = Project.new
  end

  def show
    # @tasks = Task.where(project_id: @project)
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to root_path, notice: "Проект успешно создан" }
        format.json { render projects_path, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_path, notice: "Проект успешно обновлен" }
        format.json { render projects_path, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path, notice: "Проект успешно удален" }
      format.json { head :no_content }
    end
  end


  private

  def project_params
    params.require(:project).permit(:name)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end