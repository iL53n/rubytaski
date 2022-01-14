class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale

  # def after_sign_in_path_for(resource)
  #   if resource.admin?
  #     root_path
  #     '/admin_books'
  #   else
  #     root_path
  #   end
  # end

  def index; end

  def locale; end

  private

  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    logger.debug "* Locale set to '#{locale}'"
    I18n.locale = locale
  end
end
