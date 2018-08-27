require 'rails_helper'

feature 'Welcome page' do
  scenario 'Open app' do
    visit('/')
    expect(page).to have_content('Olá')
  end

  scenario 'Move to beach cleans' do
    visit('/')
    click_on('Beach clean')

    expect(page).to have_content('New beach clean')
  end

  scenario 'Move to whale watching' do
    visit('/')
    click_on('Whale watch')

    expect(page).to have_content('New observation')
  end
end
