class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :set_project, only: [:create]

  def sort
    @task = Task.find(params[:task_id])
    @task.update(task_params)
    render body: nil
  end

  def edit
    authorize @task
  end

  def create
    @task = Task.new(task_params)
    authorize @task
    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: 'Задача успешно добавлена' }
        format.json { head :ok }
      else
        format.html { redirect_to root_path, alert: 'Минимальная длинна сообщения 3 символа' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @task
    respond_to do |format|
      if @task.update(task_params)
        # format.js
        format.html { redirect_to root_path, notice: 'Задача была успешно обновлена' }
        format.json { head :ok }
      else
        format.html { redirect_to root_path, alert: 'Минимальная длинна сообщения 3 символа' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @task
    @task.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Задача была удалена' }
      format.json { head :ok }
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :status, :project_id, :task, :id, :row_order_position, :task_id, :excepted_datetime)
  end
end
