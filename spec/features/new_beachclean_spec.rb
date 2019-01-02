require 'rails_helper'
require_relative '../support/new_beachclean_form'

feature 'Start logging' do
  let(:new_form) { NewBeachcleanForm.new }

  scenario 'a new beach clean', js: true do
    new_form.fill_in_with(
      date: '2019-01-31',
      place: 'Paindane'
    ).submit

    expect(page).to have_content(/SAVE/i)
    expect(page).to have_content(/SUBMIT/i)
    expect(page).to have_content(/DELETE/i)

    ItemCategory.each do |category|
      expect(page).to have_content(category.full_name)
    end

    click_on 'Submit'

    # expect(page).to have_content('Date: 31/01/2019') # FIXME
    expect(page).to have_content('Place: Paindane')
    expect(page).to have_content('Estimated weight: 0 kg')

    expect(Beachclean.last).not_to be_nil
    # expect(Beachclean.last.date.strftime("%Y-%m-%d")).to eq('2019-01-31') # FIXME
    expect(Beachclean.last.place.name).to eq('Paindane')
  end

  scenario 'a new beachclean without filling in the place field leaves place empty' do
    new_form.fill_in_with(
      date: '2018-12-31',
      place: ''
    ).submit

    expect(page).to have_content(/SUBMIT/i)

    click_on 'Submit'

    expect(Beachclean.last).not_to be_nil
    expect(Beachclean.last.date.strftime("%Y-%m-%d")).to eq('2018-12-31')
    expect(Beachclean.last.place.name).to be_empty
  end

  scenario 'a new beachclean with selecting other place shows dialog to input location' do
    new_form.fill_in_with(
      place: 'Other'
    )

    expect(page).to have_content('Grab my current location')
  end
end
