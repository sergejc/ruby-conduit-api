class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :articles, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: {case_sensitive: false }, presence: true, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }

  def generate_jwt
    exp = 60.days.from_now.to_i
    secret_key_base = Rails.application.secrets.secret_key_base

    JWT.encode({ id: id, exp: exp }, secret_key_base)
  end
end
