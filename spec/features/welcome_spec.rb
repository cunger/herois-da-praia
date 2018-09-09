require 'rails_helper'

feature 'Welcome page' do
  scenario 'Open app' do
    visit('/')

    expect(page).to have_content('Olá')
    expect(page).to have_content('New beach clean')
    expect(page).to have_content('New whale watch')
    expect(page).to have_content('Previous activity')

    # TODO If admin, then also 'Analytics'
  end
end
