class Recipe < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :image, allow_blank: true, url: true
  has_many :groups, dependent: :destroy
  has_many :ingredients, dependent: :destroy
end
