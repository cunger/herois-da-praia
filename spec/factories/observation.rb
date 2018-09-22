FactoryBot.define do
  factory :observation do
    log_id { FactoryBot.create(:log).id }
    # TODO
  end
end
