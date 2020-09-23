require 'rails_helper'
require 'capybara/dsl'

RSpec.describe 'Test Tasks' do


  # Перед каждым тестом создать пользователя и создать Новый Проект
  before :each do
    @user = User.new(email: 'admin@admin.ru', password: '123456')
    @user.save
    login_as(@user)
    @project = Project.create(name: "Create Project", user_id: @user.id)
  end

  # Внутри проекта можно создать новую задачу
  it 'can create Tasks' do
    visit '/'
    fill_in 'name', with: 'Test task'
    click_button "Add Task"
    expect(page).to have_content('Test task')
  end


  # Пользователь может удалить проект
  it 'can delete task' do
    @task = Task.create(name:"Test Tast", status: false, project_id: @project.id)
    visit '/'
    expect {click_link "delete_task_#{@task.id}" }.to change(Task, :count).by(-1)
  end



  # Тестирование контроллера Tasks, экшен Create/Delete
  describe TasksController, type: :controller do
    it "has a 200 status code" do
      post :create, xhr: true, params: { task: { name: "Create Task", project_id: @project.id, status: false }, project_id: @project.id}
      response.code.should == '200'
    end

    it "Can delete Task" do
      @task = Task.create(name: "Test Task", project_id: @project.id)
      expect do
        @task.destroy
      end.to change(Task, :count).by(-1)
      end
  end

end