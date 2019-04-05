class Admin::UsersController < ApplicationController

  def index
    @users = User.where(role: 1)
  end

  def show
  end

end
