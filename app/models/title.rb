class Title < ApplicationRecord
  has_many :user_title
  has_many :user, through: :user_title
end
