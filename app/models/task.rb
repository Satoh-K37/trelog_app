class Task < ApplicationRecord
    # has_one_attached :image
    mount_uploader :image, ImageUploader
    belongs_to :user
    
    #タスク名が入力されていないと検証エラーになる。30文字以内じゃないとエラーになる
    validates :title, presence: true,length: { maximum: 30 }
    # length: { in: 1..30 }
    # 重量は自重で行うこともあるので、未入力は許可するけど文字は受け付けないようにする
    # validates :weight, numericality: :only_integer
    #レップ数が入力されていないとエラーになる。数値以外は受け付けない
    validates :rep, presence: true, numericality: :only_integer
    #セット数が入力されていないとエラーになる。数値以外は受け付けない
    validates :set_count, presence: true, numericality: :only_integer

    #文字数が300文字を越えると検証エラーになる
    validates :memo, length: { maximum: 300 }

    scope :recent, -> { order(created_at: :desc) }
    # これだとN+1問題が起こるらしい…
    # enum status: {未完了:0, 完了:1}
    #   {unfinished: '未完了', done: '完了'}
    
    private

    # オリジナルの検証。タイトルにカンマを含ませないようにする。なんかエラーがでる
    # def validate_name_not_includeing_coma
    #   errors.add(:title, 'にカンマを含めることはできません') if name&.include?(',')
    # end

end
