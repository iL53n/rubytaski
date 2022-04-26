class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: :update

  layout false

  def me
    @user = current_user
    render status: :ok, methods: [:image_url]
  end

  def update
    if @user.update(user_params)
      render status: :ok, methods: [:avatar_url],
        json: {notice: "Successfully updated user."}
    else
      error_response(@user, :unprocessable_entity)
    end
  end

  private

  def load_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.permit(
      :id,
      :email,
      :nick_name,
      :date_of_birth,
      :locale,
      :parent,
      :avatar
    )
  end
end
