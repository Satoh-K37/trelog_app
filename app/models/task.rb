class Task < ApplicationRecord
    belongs_to :user
    #タスク名が入力されていないと検証エラーになる。30文字以内じゃないとエラーになる
    validates :title, presence: true, length: { in: 1..30 }
    #セット数が入力されていないとエラーになる。数値以外は受け付けない
    validates :set_count, presence: true, numericality: :only_integer
    #レップ数が入力されていないとエラーになる。数値以外は受け付けない
    validates :rep, presence: true, numericality: :only_integer
    #文字数が300文字を越えると検証エラーになる
    validates :memo, length: { maximum: 300 }

    scope :recent, -> { order(created_at: :desc) }
    
    private

    # オリジナルの検証。タイトルにカンマを含ませないようにする。なんかエラーがでる
    def validate_name_not_includeing_coma
      errors.add(:title, 'にカンマを含めることはできません') if name&.include?(',')
    end

end
