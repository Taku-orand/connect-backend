class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true, length: { minimum: 8, message: 'は8文字以上入力してください'}
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :events, dependent: :destroy
end
