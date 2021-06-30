FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    name { 'name1' }
    description { 'description1' }
    deadline { '2021-05-01' }
    status { '完了' }
    priority { '高' }
  end
  factory :task2, class: Task do
    name { 'name2' }
    description { 'description2' }
    deadline { '2021-06-01' }
    status { '未着手' }
    priority { '低' }
  end
  factory :task3, class: Task do
    name { 'name1' }
    description { 'description3' }
    deadline { '2021-07-01' }
    status { '未着手' }
    priority { '高' }
  end
end
