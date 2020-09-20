require 'rails_helper'

# посетить страницу
# заполнить форму
# нажать Submit
# Проверить наличие текста на странице


feature 'CRUD Tasks' do


  # Перед каждым тестом создать пользователя и создать Новый Проект
  before :each do
    @user = User.new(email: 'admin@admin.ru', password: '123456')
    @user.save
    login_as(@user)
    visit '/'
    fill_in 'project_name', with: 'Test Project'
    click_button "Create Project"
    expect(page).to have_content('Test Project')
  end

  # Внутри проекта можно создать новую задачу
  scenario 'can create Tasks' do

    visit '/'
    fill_in 'name', with: 'Test task'
    click_button "Add Task"
    expect(page).to have_content('Test task')
  end

end