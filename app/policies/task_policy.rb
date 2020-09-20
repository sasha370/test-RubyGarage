class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end


  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user == @record.project.user
  end

  def show?
    @user == @record.project.user
  end

  def create?
    @user == @record.project.user
  end

  def new?
    @user == @record.project.user
  end

  def update?
    @user == @record.project.user
  end

  def edit?
    @user == @record.project.user
  end

  def destroy?
    @user == @record.project.user
  end
end
