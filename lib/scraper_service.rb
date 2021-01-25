require 'nokogiri'
require 'open-uri'
require_relative 'recipe'
# service object is a controller helper

class ScrapeAllRecipesService

  def initialize(keyword)
    @keyword = keyword
  end

  def call
    file = 'lib/cheesecake.html'  # or 'strawberry.html'
    doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')
    recipes = []
    doc.search('.fixed-recipe-card').first(5).each do |recipe_card|
      name = recipe_card.search('a .fixed-recipe-card__title-link').text.strip
      description = recipe_card.search('.fixed-recipe-card__description').text.strip
      rating = recipe_card.search('.stars').attribute("data-ratingstars").text.to_f.round(2)
      recipe_url = recipe_card.search('.grid-card-image-container a').attribute('href').text
      recipe_html = open(recipe_url).read
      recipe_doc = Nokogiri::HTML(recipe_html, nil, 'utf-8')
      prep_time = recipe_doc.search('.recipe-meta-item-body').first.text.strip
      # create an instance of a recipe
      recipes << Recipe.new(
        name: name,
        description: description,
        rating: rating,
        prep_time: prep_time
      )
    end
    recipes
  end
end
# use this line in the controller!
ScrapeAllRecipesService.new('cheesecake').call
# this returns recipes

