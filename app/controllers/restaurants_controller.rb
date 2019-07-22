class RestaurantsController < ApplicationController
  
  # Let's fake a database records
  RESTAURANTS = {
    1 => { name: "Dishoom", address: "Shoreditch, London", category: "indian" },
    2 => { name: "Sushi Samba", address: "City, London", category: "japanese" }
  }
  
  def index
    if params[:food_type] == nil
      @restaurants = RESTAURANTS
    else
      @category = params[:food_type]
      @restaurants = RESTAURANTS.select { |id, r| r[:category] == @category }
    end
  end

  def create
    name = params[:name]
    address = params[:address]
    category = params[:category]
    RESTAURANTS[RESTAURANTS.length + 1] = { name: name, address: address, category: category }
    render plain: "Add to DB restaurant '#{name}' with address '#{address}'"
  end

  def show
    id = params[:id]
    render plain: "Not an appropriate id: #{id}" unless id.match?(/\A[0-9]+\Z/)
    id = id.to_i
    render plain: "This id doesn't exists: #{id}" if RESTAURANTS[id].nil?
    @restaurant = RESTAURANTS[id]
  end
end
