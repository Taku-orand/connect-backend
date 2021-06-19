class Tagging < ApplicationRecord
  belongs_to :question
  belongs_to :tag

  validates :question_id, presence: true
  validates :tag_id, presence: true
end
