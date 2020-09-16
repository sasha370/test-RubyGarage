class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:create]


  def sort
    @task = Task.find(params[:task_id])
    @task.update(task_params)
    render body: nil
  end

  def index
    # отображаем все проекты, в которых пользователь = текущему пользователю
    @tasks = Task.all.where(project_id: @project)
  end

  def show
    @tasks = Task.all.where(project_id: @project)
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: 'Задача успешно добавлена' }
        format.json { head :ok }
      else
        format.html { redirect_to root_path, alert: 'Ошибка при сохранении задачи' }
        # format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        # format.js
        format.html { redirect_to root_path, notice: 'Задача была успешно обновлена' }
        format.json { head :ok }
      else
        format.html { redirect_to root_path, alert: 'Ошибка при обновлении задачи' }
        # format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Задача была удалена' }
      format.json { head :ok }
    end
  end


  private

  # Т.к. задача привязанна к конкретному проекту, то надо его выбрать из передаваемых params
  def set_project
    @project = Project.find(params[:project_id])
  end


  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :status, :project_id, :task, :id, :row_order_position, :task_id)
  end
end
