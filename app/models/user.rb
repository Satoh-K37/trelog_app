class User < ApplicationRecord
  authenticates_with_sorcery!
  has_one_attached :icon_image
  has_many :tasks
  
  # ユーザ名は30文字以内
  validates :user_name, presence: true, length:  { maximum: 30 }
  # パスワードが新しく設定されるか、既存のパスワードに変更が加えられていたらバリデーションをかける。
  validates :password, presence: true,length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  # ログインの時にメールアドレスを求めるので、ユニークにしている。
  validates :email, presence: true, uniqueness: true
  scope :recent, -> { order(created_at: :desc) }
  # トークンがユニークでないと他別のユーザのPWを変更してしまう。
  # これがあると新規ユーザーの作成に失敗するので一旦コメントアウト。
  # sパスワードリセットを途中で放棄してるからその時にトークンを発行してしまっているせいかも試しれん。なる早で解決したい。
  # validates :reset_password_token, uniqueness: true
  
end