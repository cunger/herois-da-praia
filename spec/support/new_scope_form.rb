class NewScopeForm
  include Capybara::DSL

  def visit_from_beachclean
    visit('/beachclean')
    click_on('New beach clean')
    self
  end

  def visit_from_whalewatch
    visit('/whalewatch')
    click_on('New whale watch')
    self
  end

  def fill_in_with(params = {})
    fill_in('Date', with: params[:date]) if params.has_key?(:date)
    select(params[:place], from: 'Place') if params.has_key?(:place)
    self
  end

  def submit
    click_button('Start logging')
  end
end