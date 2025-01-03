class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale, only: :locale

  include ApiErrors

  # def after_sign_in_path_for(resource)
  #   if resource.admin?
  #     root_path
  #     '/admin_books'
  #   else
  #     root_path
  #   end
  # end

  def index
  end

  def locale
  end

  def current_user
    super
  end

  private

  def set_locale
    I18n.locale = current_user.locale || request.env["HTTP_ACCEPT_LANGUAGE"].scan(/^[a-z]{2}/).first
  end
end
