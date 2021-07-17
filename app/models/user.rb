class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :requests, dependent: :destroy
end
