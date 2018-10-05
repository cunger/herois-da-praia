FactoryBot.define do
  factory :item do
    beachclean_id { FactoryBot.create(:beachclean).id }
    category { ItemCategory::TOOTHBRUSH }
    quantity { 1 }
  end
end
