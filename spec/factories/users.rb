FactoryBot.define do
  factory :user do
    id { 40 }
    name { "tanaka" }
    email { "tanaka@email.com" }
    password { "111111"  }
    password_confirmation { "111111" }
    admin { false }
  end
  factory :user2, class: User do
    id { 41 }
    name { "admin" }
    email { "admin@email.com" }
    password { "000000"  }
    password_confirmation { "000000" }
    admin { true }
  end
  factory :user3, class: User do
    id { 50 }
    name { "suzuki" }
    email { "suzuki@email.com" }
    password { "111111"  }
    password_confirmation { "111111" }
    admin { false }
  end
  factory :user4, class: User do
    id { 51 }
    name { "admin2" }
    email { "admin2@email.com" }
    password { "000000"  }
    password_confirmation { "000000" }
    admin { true }
  end
end
