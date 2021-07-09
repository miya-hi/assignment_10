require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  before do
    @user3 = FactoryBot.create(:user3)
    @user4 = FactoryBot.create(:user4)
    @task = FactoryBot.create(:task)
    @label = FactoryBot.create(:label)
    @label2 = FactoryBot.create(:label2)
  end
  describe 'ラベル管理機能' do
    context '管理者でログインした場合' do
      it 'ラベルが登録できる' do
        visit new_session_path
        fill_in (I18n.t('sessions.new.email')), with: @user4.email
        fill_in (I18n.t('sessions.new.password')), with: @user4.password
        click_button (I18n.t('sessions.new.log_in'))
        visit new_admin_label_path
        fill_in 'label_name', with: '至急'
        click_button (I18n.t('admin.labels.new.submit'))
        expect(page).to have_content '至急'
      end
      it 'ラベルが削除できる' do
        visit new_session_path
        fill_in (I18n.t('sessions.new.email')), with: @user4.email
        fill_in (I18n.t('sessions.new.password')), with: @user4.password
        click_button (I18n.t('sessions.new.log_in'))
        visit admin_labels_path
        click_link (I18n.t('admin.labels.index.destroy')), match: :first
        page.driver.browser.switch_to.alert.accept
        visit admin_labels_path
        expect(find('.destroy_test')).not_to have_content '仕事用'
      end
    end
  end
  describe 'ラベル登録・検索機能' do
    before do
      visit new_session_path
      fill_in (I18n.t('sessions.new.email')), with: @user3.email
      fill_in (I18n.t('sessions.new.password')), with: @user3.password
      click_button (I18n.t('sessions.new.log_in'))
      visit new_task_path
      fill_in 'task_name', with: 'task1'
      fill_in 'task_description', with: 'description1'
      fill_in 'task_deadline', with: '002021-08-01'
      select '着手中', from: 'task_status'
      select '高', from: 'task_priority'
      check 'task_label_ids_1'
      click_button 'commit'
    end
    context 'タスク作成画面でラベルを選択した場合' do
      it 'ラベルが登録できる' do
        expect(find('.labels_test')).to have_content '私用'
    end
  end
    context 'タスク一覧画面でラベルを検索した場合' do
      it 'ラベルが検索できる' do
        visit tasks_path
        select '私用', from: (I18n.t('tasks.index.label'))
        click_button (I18n.t('tasks.index.search'))
        expect(find('.labels_find_test')).to have_content '私用'
      end
    end
  end
end
