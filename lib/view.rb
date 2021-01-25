class View
  def display_recipes(recipes) # an array of instances
    puts "-" * 20
    puts "Here are your recipes:"
    recipes.each_with_index do |recipe, idx|
      x_mark = recipe.done? ? "X" : " "
      puts "#{idx + 1}. [#{x_mark}] #{recipe.name} - #{recipe.description} - Prep: #{recipe.prep_time} - Rating: #{recipe.rating}"
    end
    puts "-" * 20
  end

  def ask_for_index
    puts "Please choose a number:"
    print "> "
    gets.chomp.to_i - 1
  end

  def ask_for(thing)
    puts "Please enter the #{thing} for your recipe:"
    print "> "
    gets.chomp
  end
end
