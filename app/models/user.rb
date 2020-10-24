class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :icon_image, ImageUploader
  has_many :tasks
  # タスク作成の際にセレクトボックスでタイトルを設定するために中間テーブルを介して、タスクタイトルを保存しているテーブルにアクセスしてデータを取得する想定
  
  # has_many :title,  through: :user_title, source: :title
  has_many :user_title
  has_many :title, through: :user_title
  
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
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  
end