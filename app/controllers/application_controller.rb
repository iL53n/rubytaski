class ApplicationController < ActionController::Base
  before_action :authenticate_user!

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
end
