class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  EMAIL = /(?<login>\S+)\@(?<domain>\S+)/
  before_save :set_nick_name

  # Fix it, set default firstly from browser
  before_validation :default_locale

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true
  validates :locale, inclusion: {in: %w[ru en], message: "%{value} is not valid value"}

  has_many :tasks
  has_many :stars

  has_one_attached :avatar

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
