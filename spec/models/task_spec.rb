require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  before do
    @task = FactoryBot.create(:task)
    @task2 = FactoryBot.create(:task2)
    @task3 = FactoryBot.create(:task3)
  end
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', description: 'テスト' , deadline: '2021-05-01', status: '中' )
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: 'テスト', description: '' , deadline: '2021-05-01', status: '中' )
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: 'テスト', description: 'テスト' , deadline: '2021-05-01', status: '中' )
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.name_search('1')).to include(@task)
        expect(Task.name_search('1')).to include(@task3)
        expect(Task.name_search('1')).not_to include(@task2)
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_search('未着手')).to include(@task2)
        expect(Task.status_search('未着手')).to include(@task3)
        expect(Task.status_search('未着手')).not_to include(@task1)
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.name_search('1').status_search('未着手')).to include(@task3)
        expect(Task.name_search('1').status_search('未着手')).not_to include(@task1)
        expect(Task.name_search('1').status_search('未着手')).not_to include(@task2)
      end
    end
  end
end
