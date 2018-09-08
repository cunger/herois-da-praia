FactoryBot.define do
  factory :item do
    scope_id { FactoryBot.create(:scope).id }
    category { ItemCategory::TOOTHBRUSH }
    quantity { 0 }
  end
end
