class Recipe < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :groups, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :images, dependent: :destroy
end
