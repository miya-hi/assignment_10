require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @task = FactoryBot.create(:task)
    @task2 = FactoryBot.create(:task2)
    @task3 = FactoryBot.create(:task3)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # テストで使用するためのタスクを作成
        # タスク一覧ページに遷移
        visit task_path(@task.id)
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'name1'
        expect(page).to have_content 'description1'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'name1'
        expect(page).to have_content 'description1'
        expect(page).to have_content 'name2'
        expect(page).to have_content 'description2'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'name1'
        expect(task_list[1]).to have_content 'name2'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         visit task_path(@task.id)
         expect(page).to have_content 'name1'
         expect(page).to have_content 'description1'
         visit task_path(@task2.id)
         expect(page).to have_content 'name2'
         expect(page).to have_content 'description2'
       end
     end
  end
  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in (I18n.t('tasks.index.name')), with:'1'
        click_button (I18n.t('tasks.index.search'))
        expect(page).to have_content 'name1'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '未着手', from: (I18n.t('tasks.index.status'))
        click_button (I18n.t('tasks.index.search'))
        expect('.status_test').not_to have_content '完了'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in (I18n.t('tasks.index.name')), with:'1'
        select '未着手', from: (I18n.t('tasks.index.status'))
        click_button (I18n.t('tasks.index.search'))
        expect(page).not_to have_content 'name2'
        expect('.status_test').not_to have_content '完了'
      end
    end
  end
end
