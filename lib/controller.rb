require_relative 'view'
require_relative 'scraper_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    # Ask the user for a recipe name (=> view)
    name = @view.ask_for("name")
    # Ask the user for a recipe description (=> view)
    description = @view.ask_for("description")
    rating = @view.ask_for("rating")
    prep_time = @view.ask_for("prep time")
    # Create an instance of Recipe
    recipe = Recipe.new(
      name: name,
      description: description,
      rating: rating,
      prep_time: prep_time
    )
    # Add the recipe to the cookbook
    @cookbook.add_recipe(recipe)
  end

  def import
    # ask user for the keyword
    keyword = @view.ask_for("keyword")
    # make http request to search for that
    recipes = ScrapeAllRecipesService.new(keyword).call
    # get a list of recipes
    # send the recipes to the view to display
    @view.display_recipes(recipes)
    # ask user which recipe to import
    index = @view.ask_for_index
    recipe = recipes[index]
    # add it to the cookbook
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # Display all the recipes from the cookbook
    display_recipes
    # Ask the user which recipe index they want to delete (=> view)
    index = @view.ask_for_index
    # Ask the cookbook to delete the recipe at the index
    @cookbook.remove_recipe(index)
  end

  def mark
    display_recipes
    index = @view.ask_for_index
    @cookbook.mark_recipe(index)
  end

  private

  def display_recipes
    # Get the recipes from the cookbook
    recipes = @cookbook.all
    # Ask the view to display those recipes
    @view.display_recipes(recipes)
  end
end
