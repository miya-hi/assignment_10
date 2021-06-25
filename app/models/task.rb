class Task < ApplicationRecord
  validates :name, presence: true, length: { minumun:1, maximum: 252 }
  validates :description, presence: true, length: { minumun:1, maximum: 1000 }
  validates :deadline, presence: true
end
