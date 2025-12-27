class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, 
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
  
  has_many :code_submissions, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true, 
            format: { with: URI::MailTo::EMAIL_REGEXP }
  
  def generate_jwt
    Warden::JWTAuth::UserEncoder.new.call(self, :user, nil).first
  end
end