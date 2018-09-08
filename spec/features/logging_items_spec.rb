require 'rails_helper'
require_relative '../support/new_scope_form'

feature 'Log items:' do
  let(:scope) { FactoryBot.create(:scope) }

  scenario 'clicking on name, plus, and minus changes the count', js: true do
    visit items_scope_path(scope)

    ItemCategory.each do |category|
      name_node  = find(".item-component", text: category.full_name)
      plus_node  = find(".item-component.plus[data-item-category='#{category.code}']")
      minus_node = find(".item-component.minus[data-item-category='#{category.code}']")
      count_node = find(".item-component.count[data-item-category='#{category.code}']")

      count_node.assert_text('0')
      name_node.click
      count_node.assert_text('1')
      plus_node.click
      count_node.assert_text('2')
      minus_node.click
      count_node.assert_text('1')
    end
  end
end
