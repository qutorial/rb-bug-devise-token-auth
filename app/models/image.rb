class Image < ApplicationRecord
  belongs_to :recipe
  
  before_destroy do
    puts "Deleting #{@filename}"
  end

  def as_json(options)
    options[:only] = [:id, :recipe_id]
    super(options)
  end

end
