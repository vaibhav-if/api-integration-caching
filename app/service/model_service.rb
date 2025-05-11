require "net/http"
require "set"

class ModelService
  def initialize(year)
    @year = year
    @model_sales_data = {}
    @total_models = Set.new
  end

  def load_data
    @total_models, @car_sales = Rails.cache.fetch("cars_data_#{@year}", expires_in: 1.year) do
      fetch_data
    end
    return @total_models, @car_sales
  end

  private
  def fetch_data
    (1981..@year).each do |year|
      uri = URI("https://vpic.nhtsa.dot.gov/api/vehicles/getmodelsformakeyear/make/honda/modelyear/#{year}?format=json")
      res = Net::HTTP.get_response(uri)
      data = JSON.parse(res.body)
      data = data["Results"].map { |hash| hash["Model_Name"] }
      @model_sales_data[year] = []
      @model_sales_data[year] += data
      @total_models.merge(data)
    end
    return @total_models, @model_sales_data
  rescue => error
    puts "Response failed due to: #{error}"
  end
end
