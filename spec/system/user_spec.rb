require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user2)
  end
  describe 'ユーザー登録機能' do
    context 'ユーザーを新規登録した場合' do
      it '登録したユーザーが表示される' do
        visit new_user_path
        fill_in 'user_name', with:'yamada'
        fill_in 'user_email', with:'yamada@email.com'
        fill_in 'user_password', with:'000000'
        fill_in 'user_password_confirmation', with:'000000'
        click_button (I18n.t('users.new.submit'))
        expect(page).to have_content 'yamada'
        expect(page).to have_content 'yamada@email.com'
      end
    end
    context 'ログインせずタスク一覧に飛ぼうとしたとき' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'ユーザー登録'
      end
    end
  end
  describe 'セッション機能' do
      before do
        visit new_session_path
        fill_in (I18n.t('sessions.new.email')), with: @user.email
        fill_in (I18n.t('sessions.new.password')), with: @user.password
        click_button (I18n.t('sessions.new.log_in'))
      end
    context 'ユーザーが登録されている場合' do
      it 'ログインができる' do
        expect(page).to have_content 'ログインしました'
      end
      it 'マイページに飛べる' do
        expect(current_path).to eq user_path(id: @user.id)
      end
      it '他ユーザーのページに飛ぶとタスク一覧画面へ遷移する' do
        visit user_path(id: @user2.id)
        expect(page).to have_content "タスク一覧"
      end
      it 'ログアウトができる' do
        click_link (I18n.t('layouts.application.log_out'))
        expect(current_path).to eq new_session_path
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe 'ユーザー管理機能' do
      before do
        visit new_session_path
        fill_in (I18n.t('sessions.new.email')), with: @user2.email
        fill_in (I18n.t('sessions.new.password')), with: @user2.password
        click_button (I18n.t('sessions.new.log_in'))
        visit admin_users_path
      end
    context '管理ユーザーが登録されている場合' do
      it '管理ユーザーは管理画面にアクセスできる' do
        expect(page).to have_content '管理者権限'
      end
      it '一般ユーザーは管理画面にアクセスできない' do
        click_link (I18n.t ('layouts.application.log_out'))
        visit new_session_path
        fill_in (I18n.t('sessions.new.email')), with: @user.email
        fill_in (I18n.t('sessions.new.password')), with: @user.password
        click_button (I18n.t ('sessions.new.log_in'))
        visit admin_users_path
        expect(page).to have_content 'アクセス権限がありません'
      end
      it '管理ユーザーはユーザーの新規登録ができる' do
        click_link (I18n.t('admin.users.index.sign_up'))
        fill_in 'user_name', with: 'suzuki'
        fill_in 'user_email', with: 'suzuki@email.com'
        fill_in 'user_password', with: '222222'
        fill_in 'user_password_confirmation', with: '222222'
        click_button (I18n.t('admin.users.new.submit'))
        expect(page).to have_content '「suzuki」を登録しました'
      end
      it '管理ユーザーはユーザーの詳細画面にアクセスできる' do
        click_link (I18n.t('admin.users.index.show')), match: :first
        expect(page).to have_content "#{@user.name}のページ"
      end
      it '管理ユーザーはユーザーの編集画面からユーザーを編集できる' do
        click_link (I18n.t('admin.users.index.edit')), match: :first
        fill_in 'user_name', with: 'takahashi'
        click_button (I18n.t('admin.users.edit.submit'))
        expect(page).to have_content '「takahashi」の情報を更新しました'
      end
      it '管理ユーザーはユーザーを削除できる' do
        click_link (I18n.t('admin.users.index.destroy')), match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "「#{@user.name}」を削除しました"
      end
    end
  end
end
