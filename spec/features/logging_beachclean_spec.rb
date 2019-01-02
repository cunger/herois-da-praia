require 'rails_helper'
require_relative '../support/new_beachclean_form'

feature 'Log items:' do
  scenario 'clicking on name, plus, and minus changes the count', js: true do
    NewBeachcleanForm.new.fill_in_with(
      date: '2020-01-03',
      place: 'Paindane'
    ).submit

    ItemCategory.each do |category|
      name_node  = find(".item-component", text: /\A#{category.full_name}\Z/)
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
