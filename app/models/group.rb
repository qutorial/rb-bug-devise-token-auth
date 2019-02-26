class Group < ApplicationRecord
  belongs_to :recipe
  has_many :ingredients, dependent: :destroy
end
