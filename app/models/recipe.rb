class Recipe < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :image, allow_blank: true, url: true
end
