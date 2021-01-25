class Recipe
  attr_reader :name, :description, :rating, :prep_time

  def initialize(attributes = {})
    @name = attributes[:name] # string
    @description = attributes[:description] # string
    @rating = attributes[:rating]
    @prep_time = attributes[:prep_time]
    # @done = attributes[:done] ? attributes[:done] : false
    @done = attributes[:done] || false
  end

  def mark_as_done!
    @done = !@done
  end

  def done?
    @done
  end
end

# Old Way
# Recipe.new('cheescake', 'desc....')

# New Way
# p Recipe.new(
#   prep_time: '30 min',
#   description: 'desc....',
#   rating: 4
# )
