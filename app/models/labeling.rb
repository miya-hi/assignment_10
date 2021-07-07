class Labeling < ApplicationRecord
  belongs_to :task_id
  belongs_to :label_id
end
