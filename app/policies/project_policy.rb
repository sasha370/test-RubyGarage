class ProjectPolicy < ApplicationPolicy
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
    @user == @record.user
  end

  def show?
    @user == @record.user
  end

  def create?
    @user == @record.user
  end

  def new?
    @user == @record.user
  end

  def update?
    @user == @record.user
  end

  def edit?
    @user == @record.user
  end

  def destroy?
    @user == @record.user
  end

end
