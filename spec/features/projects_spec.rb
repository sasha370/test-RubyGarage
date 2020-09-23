require 'rails_helper'
require 'capybara/dsl'

RSpec.describe 'Test Project' do

  # Перед каждым тестом создать пользователя и щалогинится
  before :each do
    @user = User.new(email: 'admin@admin.ru', password: '123456')
    @user.save
    login_as(@user)
  end


  # Залогиненый пользоватьль может создавать новый проект
  it 'can create project' do
    visit '/'
    fill_in 'project_name', with: 'Test Project'
    click_button "Create Project"
    expect(page).to have_content('Test Project')
  end

  # Пользователь может удалить проект
  it 'can delete project' do
    @project = Project.create(name: 'Delete Project', user_id: @user.id)
    visit '/'
    expect { click_link "delete_#{@project.id}" }.to change(Project, :count).by(-1)
  end


  # Тест контроллераб метод Create/delete
  describe ProjectsController, type: :controller do
    before :each do
      @user = User.create(email: 'admin1@admin.ru', password: '123456')
      login_as(@user)
    end

    it "has a 200 status code" do
      post :create, xhr: true, params: { project: { name: "Create Project", user_id: @user } }
      expect {response.code == '200' }
    end

    it "Can delete" do
      @user = User.create(email: 'admin110@admin.ru', password: '123456')
      @project = Project.create!(name: "Test Project", user_id: @user.id)
      expect do
        @project.destroy
      end.to change(Project, :count).by(-1)

    end
  end
end