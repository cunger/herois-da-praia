FactoryBot.define do
  factory :item do
    log_id   { FactoryBot.create(:log).id }
    category { ItemCategory::TOOTHBRUSH }
    quantity { 0 }
  end
end
