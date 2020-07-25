class UserMailer < ApplicationMailer
    # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject

  # メールの送信元のアドレスを指定できる
  default from: 'from@example.com'
  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    # メールの宛先、件名を指定
    mail( to: user.email, 
          subject: 'パスワードリセット')
  end
end
