class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :tasks
  # has_secure_password
  validates :user_name, presence: true, length: { in: 1..30 }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:password_digest] }
  
  validates :password, confirmation: true, if: -> { new_record? || changes[:password_digest] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password_digest] }

  validates :email, presence: true, uniqueness: true
  # トークンがユニークでないと他別のユーザのPWを変更してしまう。
  # これがあると新規ユーザーの作成に失敗するので一旦コメントアウト。パスワードリセットを途中で放棄してるからその時にトークンを発行してしまっているせいかも試しれん。なる早で解決したい。
  # validates :reset_password_token, uniqueness: true
  
end