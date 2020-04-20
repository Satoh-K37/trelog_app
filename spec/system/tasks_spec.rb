require 'rails_helper'

# ログインしてないユーザーがタスク機能を使えないか確認するテスト書いてなかったわね…あとで追加します。

describe 'タスク管理機能', type: :system do
  # ログインユーザをletで定義
  let(:user_a){ create( :user )}
  let(:user_b){ create( :user )}
  # ユーザAのタスクを作成
  let!(:task_a){ create( :task, user: user_a)}
  # let!(:taks_a){ FactoryBot.create(:task, title: '最初のトレーニング', weight: '10' , rep: '10', set_count: '2', user: user_a) }

  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    # page(画面)に期待するよ、…することを　最初のトレーニングがあるということを　的な感じらしい。
      it{ expect(page).to have_content '最初のトレーニング' }
  end

  # タスク一覧に作成したタスクが表示されているか？
  describe 'タスク一覧表示機能' do
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
  describe 'タスク詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      before { login( user_a ) }
    
      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end

  #
  describe 'タスク新規作成機能' do
    before { login( user_a ) }
    before do
      visit new_task_path
      fill_in 'task_title', with: task_title
      fill_in 'weight', with: task_weight
      fill_in 'rep', with: task_rep
      fill_in 'set_count', with: task_set_count
      fill_in 'task_memo', with: task_memo
      click_button '登録'
      tasks_path
    end

    context '新規作成画面で正しく入力し登録したとき' do
      let(:task_title){ '新しいテストをかく' }
      let(:task_weight){ '10' }
      let(:task_rep){ '10' }
      let(:task_set_count){ '2' }
      let(:task_memo){''}

      it '正常に登録される' do
        expect(page).to have_content '新しいテストをかく' 
      end
    end

    context 'タイトルを空白で登録した時' do
      let(:task_title){ '' }
      let(:task_weight){ '10' }
      let(:task_rep){ '10' }
      let(:task_set_count){ '2' }
      let(:task_memo){''}

      it 'エラー「タイトルを入力してください」' do
        within '#error_explanation' do
          expect(page).to have_content 'タイトルを入力してください'
        end
      end
    end
    
    context 'タイトルを30文字以上で入力した場合' do
      let(:task_title){ 'あああああああああああああああああああああああああああああああ' }
      let(:task_weight){ '10' }
      let(:task_rep){ '10' }
      let(:task_set_count){ '2' }
      let(:task_memo){''}

      it 'タイトルは30文字以内で入力してください' do
        within '#error_explanation' do
          expect(page).to have_content 'タイトルは30文字以内で入力してください'
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
      let(:task_memo){''}
      
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
      let(:task_memo){''}

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
      let(:task_memo){''}

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
      let(:task_memo){''}

      it 'エラー「セットは数値で入力してください」' do
        within '#error_explanation' do
          expect(page).to have_content 'セットは数値で入力してください'
        end
      end
    end
    
    # # メモが300文字以上の時
    context 'メモに300文字以上入力して登録した時' do
      let(:task_title){ 'テスト' }
      let(:task_weight){ '10' }
      let(:task_rep){ '10' }
      let(:task_set_count){ '2' }
      # 301文字を入力させている。まじでどうにかならんかコレ…繰り返しとかのやつ調べる。
      let(:task_memo){'あああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ'}
      
      it 'メモは300文字以内で入力してください' do
        within '#error_explanation' do
          expect(page).to have_content 'メモは300文字以内で入力してください'
        end
      end
    end

  end



  describe 'タスク編集機能' do
    before { login( user_a ) }
    before do
      visit task_path(task_a)
      click_link '編集'
      fill_in 'task_title', with: task_title
      fill_in 'weight', with: task_weight
      fill_in 'rep', with: task_rep
      fill_in 'set_count', with: task_set_count
      fill_in 'task_memo', with: task_memo
      click_button '登録'
      tasks_path
    end

    context 'タスク編集編集に成功する時' do
      let(:task_title){ 'ベンチプレス' }
      let(:task_weight){ '10' }
      let(:task_rep){ '10' }
      let(:task_set_count){ '2' }
      let(:task_memo){ '' }

      # let
      it '編集に成功' do
        expect(page).to have_content 'ベンチプレス'
      end
    end

    # タイトルを空白で変更しようとした時
    context 'タイトルを空白で編集完了した場合' do
      let(:task_title){ '' }
      let(:task_weight){ '10' }
      let(:task_rep){ '10' }
      let(:task_set_count){ '2' }
      let(:task_memo){ '' }

      it 'エラー「タイトルを入力してください」' do
        within '#error_explanation' do
          expect(page).to have_content 'タイトルを入力してください'
        end
      end
    end

    context 'タイトルが30字以上の場合' do
      let(:task_title){ 'あああああああああああああああああああああああああああああああ' }
      let(:task_weight){ '10' }
      let(:task_rep){ '10' }
      let(:task_set_count){ '2' }
      let(:task_memo){ '' }

      it 'エラー「タイトルは30文字以内で入力してください」' do
        within '#error_explanation' do
          expect(page).to have_content 'タイトルは30文字以内で入力してください'
        end
      end
    end

    # レップに数値以外が入力されて編集が登録された
    context 'レップに数値以外が入力されて編集が登録された場合' do
      let(:task_title){ 'test' }
      let(:task_weight){ '10' }
      let(:task_rep){ 'test' }
      let(:task_set_count){ '2' }
      let(:task_memo){ '' }

      it 'レップは数値で入力してください' do
        within '#error_explanation' do
          expect(page).to have_content 'レップは数値で入力してください'
        end
      end
    end

    # レップに空白が入力されて編集が登録された
    context 'レップに空白が入力されて編集が登録された場合' do
      let(:task_title){ 'ベンチプレス' }
      let(:task_weight){ '10' }
      let(:task_rep){ '' }
      let(:task_set_count){ '2' }
      let(:task_memo){ '' }

      it 'レップを入力してください' do
        within '#error_explanation' do
          expect(page).to have_content 'レップを入力してください'
        end
      end
    end

    # セットに数値以外が入力されて編集が登録された
    context 'セットに数値以外が入力されて編集が登録された場合' do
      let(:task_title){ 'ベンチプレス' }
      let(:task_weight){ '10' }
      let(:task_rep){ '10' }
      let(:task_set_count){ 'test' }
      let(:task_memo){ '' }

      it 'セットは数値で入力してください' do
        within '#error_explanation' do
          expect(page).to have_content 'セットは数値で入力してください'
        end
      end
    end

    # セットに数値以外が入力されて編集が登録された
    context 'セットに空白が入力されて編集が登録された場合' do
      let(:task_title){ 'ベンチプレス' }
      let(:task_weight){ '10' }
      let(:task_rep){ '10' }
      let(:task_set_count){ '' }
      let(:task_memo){ '' }

      it 'セットを入力してください' do
        within '#error_explanation' do
          expect(page).to have_content 'セットを入力してください'
        end
      end
    end

    # メモに300文字以上の入力がされた状態で編集登録がされた場合
    # まじでどうにかしたい…
    context 'メモに300文字以上の入力がされた状態で編集登録がされた場合' do
      let(:task_title){ 'ベンチプレス' }
      let(:task_weight){ '10' }
      let(:task_rep){ '10' }
      let(:task_set_count){ '10' }
      let(:task_memo){ 'あああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ' }

      it 'メモは300文字以内で入力してください' do
        within '#error_explanation' do
          expect(page).to have_content 'メモは300文字以内で入力してください'
        end
      end
    end
  end



#一番外のend 
end