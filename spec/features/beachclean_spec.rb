require 'rails_helper'
require_relative '../support/new_scope_form'

feature 'Beach clean' do
  let(:new_scope_form) { NewScopeForm.new }

  scenario 'start a new beach clean' do
    new_scope_form.visit_from_beachclean.fill_in_with(
      date: '2018-12-31',
      place: 'Paindane'
    ).submit

    expect(Scope.last.date.strftime("%Y-%m-%d")).to eq('2018-12-31')
    expect(Scope.last.place).to eq('paindane')
  end

  scenario 'start a new beach clean without filling in form fields' do
    new_scope_form.visit_from_beachclean.fill_in_with().submit

    expect(Scope.last).to be_nil # TODO Is that really what is expected?
  end
end
