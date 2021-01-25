require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = [] # this is an array of Recipe INSTANCES!!!!
    load_csv
  end

  # CRUD - instance methods

  def all
    @recipes
  end

  def add_recipe(recipe) # recipe is an INSTANCE of Recipe
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_recipe(index)
    # get a recipe
    recipe = @recipes[index]
    # mark it as done
    recipe.mark_as_done!
    # save the csv
    save_csv
  end

  private

  def load_csv
    # TODO: fill the @recipes array with instances of Recipe from the CSV
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      # NO LONGER - row is an array of strings
      # row is a HASH
      row[:done] = row[:done] == 'true'
      recipe = Recipe.new(row)
      @recipes << recipe # We instantiate a Recipe from strings
    end
  end

  def save_csv
    # TODO: store the elements of @recipes into a CSV file
    CSV.open(@csv_file, 'wb', force_quotes: true) do |csv|
      csv << ['name', 'description', 'rating', 'prep_time', 'done']
      # @recipes is an array of instances
      @recipes.each do |recipe| # recipe is an instance of Recipe
        # CSV can not store instances, only strings
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?] # one row in the CSV
      end
    end
  end
end
