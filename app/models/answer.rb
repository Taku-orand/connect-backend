class Answer < ApplicationRecord
    belongs_to :user
    belongs_to :question
     
    has_one :like
    has_many :notifications, dependent: :destroy
end
