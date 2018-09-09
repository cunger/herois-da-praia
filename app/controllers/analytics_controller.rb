class AnalyticsController < ApplicationController
  def start
  end

  def query
    start_date = params[:startDate]
    end_date = params[:endDate]
    places = checked(Place)
    groups = checked(UserGroup)

    @data = {
      start_date: start_date,
      end_date: end_date,
      totals: { scopes: 0, items: 0, weight: 0 },
      counts: {}
    }

    results = query_items(start_date, end_date, places, groups)
    results.each do |item|
      @data[:totals][:items] += item.quantity
      @data[:totals][:weight] += item.weight
    end

    @data[:totals][:scopes] = results.distinct.count(:scope_id)
  end

  def view
  end

  private

  def checked(enum)
    enum.select { |e| params[e.code] == '1' }.map(&:code)
  end

  def query_items(start_date, end_date, places, groups)
    Item.joins(:scope)
        .where('date BETWEEN ? AND ?', start_date, end_date)
        .where('place IN (?)', places)
  end
end
