require 'date'

class Project
  attr_reader :start_date, :end_date

  def initialize(start_date, end_date, city_cost)
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @cost = city_cost == 'high' # Boolean true for high cost; false for low cost city
  end

  def on?(date)
    start_date <= date && date <= end_date
  end

  def travel_cost
    high_cost? ? 55 : 45
  end

  def full_cost
    high_cost? ? 85 : 75
  end

  private

  def high_cost?
    @cost
  end
end
