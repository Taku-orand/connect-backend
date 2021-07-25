class Answer < ApplicationRecord
    belongs_to :user
    belongs_to :question
     
    has_one :like
end
