FactoryBot.define do
  factory :log do
    user_id { FactoryBot.create(:user).id }
    date    { '2019-01-01' }
    place   { :guinjata }
  end
end
