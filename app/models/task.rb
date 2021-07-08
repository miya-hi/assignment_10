class Task < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings
  validates :name, presence: true, length: { minumun:1, maximum: 252 }
  validates :description, presence: true, length: { minumun:1, maximum: 1000 }
  validates :deadline, presence: true
  validates :status, presence: true
  scope :status_search, -> (status) { where(status: status) }
  scope :name_search, -> (name) { where("tasks.name like?", "%#{name}%") }
  scope :label_search, -> (label) { joins(:labels).where(labels: { id: label }) }
  enum priority: { 高: 0, 中: 1, 低: 2 }
  belongs_to :user

  # def self.status_search(_status)
  #   Task.where(status: status)
  # end
  #
  # def self.where(name:, description:, deadline:, priority:, status:)
  #   parameter = []
  #   if name.prenset?
  #     parameter = SQL.exec("select * from tasks in name == #{name}")
  #   elsif description.prenset?
  #     parameter = SQL.exec("select * from tasks in description == #{description}")
  #   elsif status.prenset?
  #     parameter = SQL.exec("select * from tasks in status == #{status}")
  #   else
  #     ...
  #   end
  #   return parameter
  # end
  # def self.find(id)
  #   parameter = SQL.exec("select * from tasks in id == #{id}")
  #   task = Task.new(parameter)
  #   return task
  # end

  # def status_search
  #   self.name "aaa"
  #   self == Task.new(name: "aaa")
  #   self.description
  # end
  #
  # def description_trim
  #   self.description.slice(0, 10) + "..."
  # end
end

# Task.new(name: "aaa").status_search
# @task.description_trim => "fdsafsadfsad..."
#
# @task = Task.find(1)
