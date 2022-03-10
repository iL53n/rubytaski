class User < ApplicationRecord
  EMAIL = /(?<login>\S+)\@(?<domain>\S+)/.freeze
  before_save :set_nick_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true
  validates :locale, inclusion: { in: %w(ru en), message: "%{value} is not valid value" }

  has_many :tasks
  has_many :stars

  private

  def set_nick_name
    self.nick_name ||= login
    # logger.debug "* Set nick_name: '#{self.nick_name}'"
  end

  def login
    email.match(EMAIL)[:login]
  end
end
