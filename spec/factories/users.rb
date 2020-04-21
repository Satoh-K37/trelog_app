FactoryBot.define do
  # factory :admin_user, class: User do ファクトリ名とクラスが異なる時はこれでいける。
  factory :user do
    #nに連番の数字が入る
    user_name { 'テストユーザ' }
    # sequence(:user_name) { |n|'テストユーザー#{n}' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    # user_name: 'test'
    # email: 'whatever@whatever.com'
    # salt: <%= salt = "asdasdastr4325234324sdfds" %>
    # crypted_password: <%= Sorcery::CryptoProviders::BCrypt.encrypt("secret", salt) %>
    # activation_state: active
  end

end
