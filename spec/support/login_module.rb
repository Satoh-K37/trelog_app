module LoginModule
  def login(user)
    # ログイン画面にアクセス
    visit login_path
    # メールアドレスを入力
    fill_in 'session_email', with: user.email
    # パスワードを入力
    fill_in 'session_password', with: 'password'
    # 「ログイン」ボタンをクリック
    click_button 'ログイン'
  end

end

