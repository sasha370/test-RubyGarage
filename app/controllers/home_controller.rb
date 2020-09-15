class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.where(user_id: current_user).order(created_at: :desc)
  end


end