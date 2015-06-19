class UsersController < ApplicationController
  before_action :check_user
  def show
  end

  def check_user
    redirect_to root_path unless current_user
  end
end
