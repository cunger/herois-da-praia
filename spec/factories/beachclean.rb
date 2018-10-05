FactoryBot.define do
  factory :beachclean do
    uuid     { '8b1b85dc-33cb-49f2-9798-9020bd3c2c34' }
    user_id  { FactoryBot.create(:user).id }
    place_id { 1 }
    date     { '2019-01-01' }
  end
end
