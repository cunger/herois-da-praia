require 'rails_helper'
require_relative '../support/new_log_form'

feature 'Start logging' do
  let(:new_log_form) { NewLogForm.new }

  scenario 'a new beach clean' do
    new_log_form.visit_from_beachclean.fill_in_with(
      date: '2018-12-31',
      place: 'Paindane'
    ).submit

    expect(Log.last.date.strftime("%Y-%m-%d")).to eq('2018-12-31')
    expect(Log.last.place).to eq('paindane')

    expect(page).to have_current_path(items_path(Log.last.id))
  end

  scenario 'a new whale watch' do
    new_log_form.visit_from_whalewatch.fill_in_with(
      date: '2019-01-01',
      place: 'Other'
    ).submit

    expect(Log.last.date.strftime("%Y-%m-%d")).to eq('2019-01-01')
    expect(Log.last.place).to eq('other')

    expect(page).to have_current_path(observations_path(Log.last.id))
  end

  scenario 'a new log without filling in the date field assumes today as default' do
    new_log_form.visit_from_beachclean.fill_in_with().submit

    expect(Log.last.date.strftime("%Y-%m-%d")).to eq(Time.now.strftime("%Y-%m-%d"))
  end

  scenario 'a new log without filling in the place field is fine' do
    new_log_form.visit_from_beachclean.fill_in_with(
      date: '2018-01-01'
    ).submit

    expect(Log.last).not_to be_nil
    expect(Log.last.date.strftime("%Y-%m-%d")).to eq('2018-01-01')
    expect(Log.last.place).to be_empty
  end
end
