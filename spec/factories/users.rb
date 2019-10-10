FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "login number #{n}" }
    sequence(:name) { |n| "my name number is #{n}" }
    sequence(:url) { |n| "my url number is #{n}" }
    sequence(:avatar_url) { |n| "avatar_url of #{n}" }
    sequence(:provider) { |n| "provider number #{n}" }
  end
end
