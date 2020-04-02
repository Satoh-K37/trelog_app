class User < ApplicationRecord
  authenticates_with_sorcery!
  # has_secure_password
  validates :user_name, presence: true, length: { in: 1..30 }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:password_digest] }
  
  validates :password, confirmation: true, if: -> { new_record? || changes[:password_digest] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password_digest] }

  validates :email, uniqueness: true
  
  
end