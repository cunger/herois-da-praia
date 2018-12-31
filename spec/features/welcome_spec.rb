require 'rails_helper'

feature 'Welcome page' do
  scenario 'Open app' do
    visit('/')

    expect(page).to have_content('How to get started')
    expect(page).to have_content('New beach clean')
    expect(page).to have_content('New whale watch')
    expect(page).to have_content('New fisheries data')
    expect(page).to have_content('Unsubmitted logs')

    # TODO If admin, then also 'Analytics'
  end

  scenario 'Clicking on "How to get started"' do
    visit('/')
    click_on('How to get started')

    expect(page).to have_content(/how you can help/i)
  end

  scenario 'Clicking on "New beach clean"' do
    visit('/')
    click_on('New beach clean')

    expect(page).to have_content(/new beach clean/i)
  end

  scenario 'Clicking on "Unsubmitted logs"' do
    visit('/')
    click_on('Unsubmitted logs')

    expect(page).to have_content(/unsubmitted logs/i)
  end
end
