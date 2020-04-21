require 'rails_helper'

RSpec.describe 'アカウント管理機能', type: :system do
  # あとで不具合出るかもしれんけど、とりあえず。問題無かったらOK！
  let!(:user_a) { create(:user) }
  let(:user_b) { create(:user) }
  let(:admin) { create(:admin_user) }

  describe 'ログイン前' do

    describe 'ユーザー新規登録' do

      before do
        visit signup_path
        fill_in 'user_user_name', with: user_name
        fill_in 'user_email', with: user_email
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password_confirmation
        click_button '登録'
      end

      context '正しくフォームに入力された' do
        let(:user_name){ 'test' }
        let(:user_email){ 'useremail@example.com' }
        let(:password){ 'password' }
        let(:password_confirmation){ 'password' }

        it '新規登録に成功' do
          expect(page).to have_selector '.notice', text: 'ユーザー登録が完了しました！'
          # '.alert-succes'
        end
      end

      context 'ユーザー名が未入力' do
        let(:user_name){ '' }
        let(:user_email){ 'useremail@example.com' }
        let(:password){ 'password' }
        let(:password_confirmation){ 'password' }

        it 'エラー「User nameを入力してください」' do
          within '#error_explanation' do
            expect(page).to have_content 'User nameを入力してください'
          end
        end
      end

      context 'メールアドレスが未入力' do
        let(:user_name){ 'test' }
        let(:user_email){ '' }
        let(:password){ 'password' }
        let(:password_confirmation){ 'password' }

        it 'エラー「Emailを入力してください」' do
          within '#error_explanation' do
            expect(page).to have_content 'Emailを入力してください'
          end
        end
      end

      context 'メールアドレスがすでに登録されている' do
        let(:user_name){ 'test' }
        let(:user_email){ user_a.email }
        let(:password){ 'password' }
        let(:password_confirmation){ 'password' }

        it 'エラー「Emailはすでに存在します」' do
          within '#error_explanation' do
            expect(page).to have_content 'Emailはすでに存在します'
          end
        end
      end

      context 'パスワードが未入力' do
        let(:user_name){ 'test' }
        let(:user_email){ 'useremail@example.com' }
        let(:password){ '' }
        let(:password_confirmation){ 'password' }

        it 'エラー「Passwordを入力してください」' do
          within '#error_explanation' do
            expect(page).to have_content 'Passwordを入力してください'
          end
        end
      end

      context 'パスワードが8文字以下' do
        let(:user_name){ 'test' }
        let(:user_email){ 'useremail@example.com' }
        let(:password){ 'pass' }
        let(:password_confirmation){ 'pass' }

        it 'エラー「Passwordは8文字以上で入力してください」' do
          within '#error_explanation' do
            expect(page).to have_content 'Passwordは8文字以上で入力してください'
          end
        end
      end
      
      
      context 'パスワード確認が未入力' do
        let(:user_name){ 'test' }
        let(:user_email){ 'useremail@example.com' }
        let(:password){ 'password' }
        let(:password_confirmation){ '' }

        it 'エラー「Password confirmationを入力してください」' do
          within '#error_explanation' do
            expect(page).to have_content 'Password confirmationを入力してください'
          end
        end
      end


      context 'パスワードとパスワード確認が一致しない' do
        let(:user_name){ 'test' }
        let(:user_email){ 'useremail@example.com' }
        let(:password){ 'password' }
        let(:password_confirmation){ 'passsword' }

        it 'エラー「Password confirmationとPasswordの入力が一致しません」' do
          within '#error_explanation' do
            expect(page).to have_content 'Password confirmationとPasswordの入力が一致しません'
          end
        end
      end
    end
  end


  describe 'ログイン後' do
    # 一般ユーザーでログイン
## アカウント詳細テスト  ##
#ユーザーAのマイページにアクセスできるか
#ユーザーBでログインしている時にユーザーAのページにアクセスできないかをテスト
    describe 'ユーザー詳細' do
      before { login( user_a ) }

      context 'ユーザーAがログインしているとき' do
        it 'ユーザーAのマイページが表示される' do
        visit user_path(user_a)
        # ログインしたユーザーのメールアドレスが表示されていること期待
        expect(page).to have_content user_a.email
        end
      end
    end
  end

##　　アカウント詳細テストここまで　　##


# ## アカウント編集テスト  ##
# #ユーザーの編集が正常にできるかをテスト（ユーザ名を変える）
# # ユーザ名を空欄もしくは30文字以上で入力した時にエラーが出るかをテスト
# # パスワードとパスワード確認が一致しないときにエラーが出るか（今は出ないですが…
#     describe 'ユーザー編集' do
#       context 'ユーザー編集が正しく完了する' do
#         it '編集に成功' do
#         end
#       end

#       context 'ユーザー名を空白で登録した場合' do
#         it 'エラー「User nameを入力してください」' do
#           within '#error_explanation' do
#             expect(page).to have_content 'User nameを入力してください'
#           end
#         end
#       end

#       context 'メールアドレスを未入力で登録しようとした場合' do
#         it 'エラー「Emailを入力してください」' do
#           within '#error_explanation' do
#             expect(page).to have_content 'Emailを入力してください'
#           end
#         end
#       end

#       context 'メールアドレスがすでに登録されている' do
#         it 'エラー「Emailはすでに存在します」' do
#           within '#error_explanation' do
#             expect(page).to have_content 'Emailはすでに存在します'
#           end
#         end
#       end

#       context 'パスワードが未入力' do
#         it 'エラー「Passwordを入力してください」' do
#           within '#error_explanation' do
#             expect(page).to have_content 'Passwordを入力してください'
#           end
#         end
#       end

#       context 'パスワードが8文字以下' do
#         it 'エラー「Passwordを入力してください」' do
#           within '#error_explanation' do
#             expect(page).to have_content 'Passwordを入力してください'
#           end
#         end
#       end

#       context 'パスワード確認が未入力' do
#         it 'エラー「Passwordは8文字以上で入力してください」' do
#           within '#error_explanation' do
#             expect(page).to have_content 'Passwordは8文字以上で入力してください'
#           end
#         end
#       end

#       context 'パスワードとパスワード確認が一致しない' do
#         it 'エラー「Password confirmationとPasswordの入力が一致しません」' do
#           within '#error_explanation' do
#             expect(page).to have_content 'Password confirmationとPasswordの入力が一致しません'
#           end
#         end
#       end

#     end
#   end

# ##　　アカウント編集テストここま
  
#   ##  アカウント一覧テスト  ###
# # 作成したユーザのメールアドレスが表示されているかを確認
# # 
# # １、前提条件で一般ユーザを作成しておく。（ログインはしない）
# # ２、ログイン画面にアクセス
# # ３、管理者ユーザでログイン
# # ４、タスク一覧画面に遷移後に、アカウント一覧ページに遷移
# # ５、１で作成した一般ユーザが存在しているかを確認
# # ６、一般ユーザでログイン（作成し、ログイン）
# # ７、アカウント一覧画面に遷移できないことを確認。
# # ８、遷移できないことが確認できたらTrue 
# # 　一般ユーザがユーザ一覧見られないことをテストするのは無理では…？５まででいい気がする…

# ##　　アカウント一覧テストここまで　　##
#   describe '管理ユーザーでログイン' do
#     # 管理者ユーザーでログイン
#     before { login( admin ) }

#     context 'ユーザー一覧にアクセスできるか' do
#       it '作成したユーザーが表示される' do
#       end
#     end
    
#     context 'ユーザーAのページにアクセスできるか' do
#       it 'ユーザーAのマイページが表示される' do
#       end
#     end


# 一番外
end










