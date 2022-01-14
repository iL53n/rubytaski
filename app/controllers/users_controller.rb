class UsersController < ApplicationController
  before_action :authenticate_user!

  def me
    @user = current_user
    render status: :ok
  end
end
