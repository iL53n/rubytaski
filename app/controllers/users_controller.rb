class UsersController < ApplicationController
  before_action :authenticate_user!

  layout false

  def me
    @user = current_user
    render status: :ok
  end
end
