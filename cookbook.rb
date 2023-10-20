# TODO: Implement the Cookbook class that will be our repository
require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file)
    @recipes = []
    @csv_file = csv_file
    load_csv(csv_file)
  end

  def all
    @recipes
  end

  def add(recipe)
    @recipes << recipe
    save_csv(@csv_file)
    return @recipes
  end

  def destroy(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv(@csv_file)
    return @recipes
  end

  private

  def load_csv(csv_file)
    CSV.foreach(csv_file, :headers => true) do |row|
      @recipes << Recipe.new(row['name'], row['description'])
    end
  end

  def save_csv(csv_file)
    headers = CSV.read(csv_file, headers: true).headers
    CSV.open(csv_file, "w", write_headers: true, headers: headers) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description]
      end
    end
  end
end
