class CarsController < ApplicationController
  def load_data
    load_data_from_service
    render json: :ok
  end

  def discontinued_vehicles
    total_models, car_sales = load_data_from_service
    year = params["year"].to_i
    prev_year = year - 1
    if car_sales[year] && car_sales[prev_year]
      discontinued_vehicles = total_models - car_sales[year] - car_sales[prev_year]
    else
      discontinued_vehicles = "Data not present for given year"
    end
    render json: discontinued_vehicles
  end

  private
  def load_data_from_service
    current_year = Date.today.year
    ModelService.new(current_year).load_data
  end
end
