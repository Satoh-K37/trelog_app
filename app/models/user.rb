class User < ApplicationRecord
  validates :user_name, presence: true, length: { in: 1..30 }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || crypted_password_changed? } # or you can use changes[:crypted_password] instead of crypted_password_changed? if you wish
  # the confirmation setting checks whether the password and password_confirmation match
  validates :password, confirmation: true, if: -> { new_record? || crypted_password_changed? }
  validates :password_confirmation, presence: true, if: -> { new_record? || crypted_password_changed? }

  validates :email, uniqueness: true
  has_secure_password
end
