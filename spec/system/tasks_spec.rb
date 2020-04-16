require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      user_a = FactoryBot.create(:user, user_name: 'ユーザーA', email: 'a@example.com')
      FactoryBot.create(:task, title: '最初のトレーニング', weight: '10', rep: '10', set_count: '2', user: user_a)
    end

    context 'ユーザーAがログインしているとき' do
      before do
        # ログイン画面にアクセス
        visit login_path
        # メールアドレスを入力
        fill_in 'メールアドレス', with: 'a@example.com'
        # パスワードを入力
        fill_in 'パスワード', with: 'password'
        # 「ログイン」ボタンをクリック
        click_button 'ログイン'
        visit tasks_path
      end

      it 'ユーザーAが作成したタスクが表示される' do
        # page(画面)に期待するよ、…することを　最初のトレーニングがあるということを　的な感じらしい。
        #have_contentはRspecでマッチャ（Matcher）と呼ばれる
        expect(page).to have_content '最初のトレーニング'
      end
    end

    context 'ユーザーBがログインしているとき' do
      before do
        FactoryBot.create(:user, user_name: 'ユーザーB', email: 'b@example.com')
        # ログイン画面にアクセス
        visit login_path
        # メールアドレスを入力
        fill_in 'メールアドレス', with: 'b@example.com'
        # パスワードを入力
        fill_in 'パスワード', with: 'password'
        # 「ログイン」ボタンをクリック
        click_button 'ログイン'
        visit tasks_path
      end

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のトレーニング'
      end
    end

  end
end
