require 'rails_helper'

# посетить страницу
# заполнить форму
# нажать Submit
# Проверить наличие текста на странице


feature 'CRUD Project' do


  # Перед каждым тестом создать пользователя и щалогинится
  before :each do
    @user = User.new(email: 'admin@admin.ru', password: '123456')
    @user.save
    login_as(@user)
  end

  # Залогиненый пользоватьль может создавать новый проект
  scenario 'can create project' do
    visit '/'
    fill_in 'project_name', with: 'Test Project'
    click_button "Create Project"
    expect(page).to have_content('Test Project')
  end

  scenario 'can edit project' do
    visit '/'
    fill_in 'project_name', with: 'Test Project'
    click_button "Create Project"
    expect(page).to have_content('Test Project')
  end


end