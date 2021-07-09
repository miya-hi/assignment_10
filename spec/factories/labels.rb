FactoryBot.define do
  factory :label do
    id { 0 }
    name { '仕事用' }
  end
  factory :label2, class: Label do
    id { 1 }
    name { '私用' }
  end
end
