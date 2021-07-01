class Task < ApplicationRecord
  validates :name, presence: true, length: { minumun:1, maximum: 252 }
  validates :description, presence: true, length: { minumun:1, maximum: 1000 }
  validates :deadline, presence: true
  validates :status, presence: true
  scope :status_search, -> (status) { where(status: status) }
  scope :name_search, -> (name) { where("name like?", "%#{name}%") }
  enum priority: { 高: 0, 中: 1, 低: 2 }
end
