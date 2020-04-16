FactoryBot.define do
  # factory :admin_user, class: User do ファクトリ名とクラスが異なる時はこれでいける。
  factory :user do
    user_name { 'テストユーザー' }
    email { 'test1@example.cpm' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
