class Ingredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :group, optional: true

  def group
    if self.group_id.nil?
      return NilGroup.new(self.recipe)
    else
      return Group.find(self.group_id)
    end
  end

end
