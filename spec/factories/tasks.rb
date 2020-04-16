FactoryBot.define do
  factory :task do
    # タイトル
    title { 'テストをかく' }
    # 重さ、重量
    weight { '10' }
    # レップ
    rep { '10' }
    # セット数
    set_count { '2' }
    # 期日
    deadline { '2021/4//29' }
    # メモ
    memo { 'テストの準備をする' }
    # userという舐めの関連を生成するのに利用する
    # 関連名とファクトリ名が異なる場合はuserの代わりに　association :user, factory: :admin_user と言った感じで記述すればOK
    user
  end
end
