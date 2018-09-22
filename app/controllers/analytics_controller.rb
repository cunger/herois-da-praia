class AnalyticsController < ApplicationController
  def start
  end

  def query
    start_date = params[:startDate]
    end_date = params[:endDate]
    groups = selected(UserGroup)

    @data = {
      start_date: start_date,
      end_date: end_date,
      totals: { beachcleans: 0, items: 0, weight: 0 },
      counts: {}
    }

    results = query_items(start_date, end_date, groups)
    results.each do |item|
      @data[:totals][:items] += item.quantity
      @data[:totals][:weight] += item.weight
    end

    @data[:totals][:beachcleans] = results.distinct.count(:beachclean)
  end

  def view
  end

  private

  def selected(enum)
    enum.select { |e| params[e.code] == '1' }.map(&:code)
  end

  def query_items(start_date, end_date, groups)
    Item.joins(:beachcleans)
        .joins(:users)
        .where('date BETWEEN ? AND ?', start_date, end_date)
        .where('group IN (?)', groups)
  end
end
