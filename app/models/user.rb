class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  EMAIL = /(?<login>\S+)\@(?<domain>\S+)/
  before_save :set_nick_name

  # Fix it, set default firstly from browser
  before_validation :default_locale

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  validates :email, presence: true
  validates :locale, inclusion: {in: %w[ru en], message: "%{value} is not valid value"}

  has_many :tasks
  has_many :stars

  has_one_attached :avatar

  def self.from_google(google_params)
    # TODO: find better solution
    if (user_by_uuid = where(provider: google_params[:provider], uid: google_params[:uid]).first)
      user_by_uuid
    elsif (user_by_email = where(email: google_params[:email]).first)
      user_by_email
    else
      create(
        provider: google_params[:provider],
        uid: google_params[:uid],
        email: google_params[:email],
        password: Devise.friendly_token[0, 20]
      )
    end

    # where(provider: google_params[:provider], uid: google_params[:uid]).first_or_create do |user|
    #   user.email = google_params[:email]
    #   user.password = Devise.friendly_token[0, 20]
    # end
  end

  def avatar_url
    # avatar.attached? ? url_for(avatar) : nil
    avatar.attached? ? rails_blob_path(avatar, only_path: true) : nil
  end

  private

  def default_locale
    self.locale ||= "en"
  end

  def set_nick_name
    self.nick_name ||= login
    # logger.debug "* Set nick_name: '#{self.nick_name}'"
  end

  def login
    email.match(EMAIL)[:login]
  end
end
