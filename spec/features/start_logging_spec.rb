require 'rails_helper'
require_relative '../support/new_scope_form'

feature 'Start logging' do
  let(:new_scope_form) { NewScopeForm.new }

  scenario 'start a new beach clean' do
    new_scope_form.visit_from_beachclean.fill_in_with(
      date: '2018-12-31',
      place: 'Paindane'
    ).submit

    expect(Scope.last.date.strftime("%Y-%m-%d")).to eq('2018-12-31')
    expect(Scope.last.place).to eq('paindane')

    expect(page).to have_current_path(items_scope_path(Scope.last.id))
  end

  scenario 'start a new whale watch' do
    new_scope_form.visit_from_whalewatch.fill_in_with(
      date: '2019-01-01',
      place: 'Other'
    ).submit

    expect(Scope.last.date.strftime("%Y-%m-%d")).to eq('2019-01-01')
    expect(Scope.last.place).to eq('other')

    expect(page).to have_current_path(scope_observations_path(Scope.last.id))
  end

  scenario 'start a new scope without filling in the date field is invalid' do
    new_scope_form.visit_from_beachclean.fill_in_with().submit

    expect(Scope.last).to be_nil
  end

  scenario 'start a new scope without filling in the place field is fine' do
    new_scope_form.visit_from_beachclean.fill_in_with(
      date: '2018-01-01'
    ).submit

    expect(Scope.last).not_to be_nil
    expect(Scope.last.date.strftime("%Y-%m-%d")).to eq('2018-01-01')
    expect(Scope.last.place).to be_empty
  end
end
