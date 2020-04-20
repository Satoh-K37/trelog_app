require 'rails_helper'

# 
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

  # タスク一覧に作成したタスクが表示されているか？
  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      before { login( user_a) }
      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
#　ユーザBがログインした時にユーザAのタスクが表示されていないかをテスト
    context 'ユーザーBがログインしているとき' do
      before { login( user_b ) }
      
      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のトレーニング'
      end
    end

  end

  #　ユーザーAが作成したタスクの詳細のテスト
  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      before { login( user_a ) }
    
      before do
        visit task_path(taks_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end

  #
  describe '新規作成機能' do
    before { login( user_a ) }
    before do
      visit new_task_path
      fill_in 'task_title', with: task_title
      fill_in 'weight', with: task_weight
      fill_in 'rep', with: task_rep
      fill_in 'set_count', with: task_set_count
      click_button '登録'
      tasks_path
    end

    context '新規作成画面で正しく入力し登録したとき' do
      let(:task_title){ '新しいテストをかく' }
      let(:task_weight){ '10' }
      let(:task_rep){ '10' }
      let(:task_set_count){ '2' }

      it '正常に登録される' do
        expect(page).to have_content '新しいテストをかく' 
      end
    end

    context 'タイトルを空欄で登録した時' do
      let(:task_title){ '' }
      let(:task_weight){ '10' }
      let(:task_rep){ '10' }
      let(:task_set_count){ '2' }

      it 'エラー「タイトルを入力してください」' do
        within '#error_explanation' do
          expect(page).to have_content 'タイトルを入力してください'
        end
      end
    end

    #  自重のことを想定すると空白でも受け付けるようにしたい。空白で入力された時は自重と入力するようにすれば空白はなくなるからいけるか…？
    # いまのところ空白を許可できないので、一旦コメントアウト。あとで空白の際は自重を入力されるようにしたら戻す
    # # 重量以外は正しく入力されているが、重量に文字が入っている時
    # context '重量に数値以外が入っている' do
    #   let(:task_title){ 'テスト' }
    #   let(:task_weight){ '' }
    #   let(:task_rep){ '10' }
    #   let(:task_set_count){ '2' }

    #   it 'エラー「重量は数値で入力してください」' do
    #     within '#error_explanation' do
    #       expect(page).to have_content '重量は数値で入力してください'
    #     end
    #   end
    # end

    # レップ以外は正しく入力されているが、レップに文字が入っている時
    context 'レップに数値以外が入っている' do
      let(:task_title){ 'テスト' }
      let(:task_weight){ '10' }
      let(:task_rep){ 'テスト' }
      let(:task_set_count){ '2' }
      
      it 'エラー「レップは数値で入力してください」' do
        within '#error_explanation' do
          expect(page).to have_content 'レップは数値で入力してください'
        end
      end
    end

    # レップ以外は正しく入力されているが、レップが空白の時
    context 'レップが空白のとき' do
      let(:task_title){ 'テスト' }
      let(:task_weight){ '10' }
      let(:task_rep){ '' }
      let(:task_set_count){ '2' }

      it 'エラー「レップを入力してください」' do
        within '#error_explanation' do
          expect(page).to have_content 'レップを入力してください'
        end
      end
    end

      # セット以外は正しく入力されているが、セットに文字が入っている時
      context 'セットに数値以外が入っているとき' do
        let(:task_title){ 'テスト' }
        let(:task_weight){ '10' }
        let(:task_rep){ '10' }
        let(:task_set_count){ 'test' }

        it 'エラー「セットは数値で入力してください」' do
          within '#error_explanation' do
            expect(page).to have_content 'セットは数値で入力してください'
          end
        end
      end

      # セット以外は正しく入力されているが、セットが空白の時
      context 'セットに空白が入っているとき' do
        let(:task_title){ 'テスト' }
        let(:task_weight){ '10' }
        let(:task_rep){ '10' }
        let(:task_set_count){ 'test' }

        it 'エラー「セットは数値で入力してください」' do
          within '#error_explanation' do
            expect(page).to have_content 'セットは数値で入力してください'
          end
        end
      end
  
  # 新規作成機能のラストのエンド
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

