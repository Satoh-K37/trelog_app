
require 'rails_helper'

# タスク一覧に作成したタスクが表示されているか？
#　ユーザBがログインした時にユーザAのタスクが表示されていないかをテスト
describe 'タスク管理機能', type: :system do
  # ログインユーザをletで定義
  let(:user_a){ create( :user )}
  let(:user_b){ create( :user )}
  # ユーザAのタスクを作成
  let!(:taks_a){ create( :task, user: user_a)}
  # let!(:taks_a){ FactoryBot.create(:task, title: '最初のトレーニング', weight: '10' , rep: '10', set_count: '2', user: user_a) }

  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    # page(画面)に期待するよ、…することを　最初のトレーニングがあるということを　的な感じらしい。
      it{ expect(page).to have_content '最初のトレーニング' }
  end

    
  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      # user.rbで定義した
      before { login( user_a) }
      it_behaves_like 'ユーザーAが作成したタスクが表示される'
      # it 'ユーザーAが作成したタスクが表示される' do
      #   expect(page).to have_content '最初のトレーニング'
      # end
    end

    context 'ユーザーBがログインしているとき' do
      before { login( user_b ) }
      
      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のトレーニング'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      before { login( user_a ) }
    
      before do
        visit task_path(taks_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
      # it 'ユーザーAが作成したタスクが表示される' do
      #   expect(page).to have_content '最初のトレーニング'
      # end

    end
  end

#一番外のend 
end

##  タスク一覧テストここまで  ##

## タスク作成のテスト ##
# １、タスク作成画面アクセス
# ２、タスク入力フォームの入力。登録ボタンのクリック
# ３、タスク一覧画面に遷移
# ４、作成したタスクが表示されているかを確認
  # describe 'タスク作成機能', type: :system do
  #   before do
  #     # １、タスク作成画面アクセス
  #     visit new_task_path
  #     # ２、タスク入力フォームの入力。登録ボタンのクリック
  #     # タイトルの入力
  #     fill_in 'タイトル', with: 'トレーニングのタスク'
  #     # 重量の入力
  #     fill_in '重量', with: 15
  #     # レップの入力
  #     fill_in 'レップ', with: 10
  #     # セットの入力
  #     fill_in 'セット', with: 2
  #     # タスクを登録するボタンをクリック
  #     click_button '登録'
  #     # ３、タスク一覧画面に遷移
  #     visit tasks_path
  #   end
  #   # ４、作成したタスクが表示されているかを確認
  #   it '作成したタスクが表示されているか' do
  #     expect(page).to have_content 'トレーニングのタスク'
  #   end
  # end

##　　タスク作成テストここまで　　##

## タスク編集のテスト  ##
# １、タスク編集画面アクセス
# ２、変更内容をフォームに入力し、登録ボタンのクリック
# ３、タスク一覧画面に遷移
# ４、変更内容のデータが正しく表示されているかを確認
# 

##　　タスク編集テストここまで　　##

## タスク詳細のテスト  ##
# １、詳細画面にアクセス
# ２、

##　　タスク詳細テストここまで　　##

