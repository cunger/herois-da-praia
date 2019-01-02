class NewBeachcleanForm
  include Capybara::DSL

  def initialize
    visit('/beachcleans/new')
    self
  end

  def fill_in_with(params = {})
    fill_in('Date', with: params[:date]) if params.has_key?(:date)
    select(params[:place], from: 'Place') if params.has_key?(:place)
    self
  end

  def submit
    find('input[type="submit"]').click
  end
end
