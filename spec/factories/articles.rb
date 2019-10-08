FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "My awesome title #{n}" }
    sequence(:content) { |n| "Read my long content #{n}" }
    sequence(:slug) { |n| "Here is my amazing slug #{n}" }
  end
end
