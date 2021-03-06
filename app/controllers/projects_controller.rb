class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]

  def create
    @project = Project.new(project_params)
    @project.user = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to root_path, notice: "Проект успешно создан" }
        format.json { head :ok }
      else
        format.html { redirect_to root_path, alert: "Минимальная длинна сообщения 3 символа" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @project
  end

  def update
        authorize @project
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to root_path, notice: "Проект успешно обновлен" }
        format.json { head :ok }
        format.js
      else
        format.html { redirect_to root_path, alert: "Минимальная длинна сообщения 3 символа" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @project
    @project.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Проект успешно удален" }
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
