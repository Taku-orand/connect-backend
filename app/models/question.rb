class Question < ApplicationRecord
  belongs_to :user

  has_one :like
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
end
