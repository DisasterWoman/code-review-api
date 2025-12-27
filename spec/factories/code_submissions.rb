FactoryBot.define do
  factory :code_submission do
    content { "MyText" }
    language { "MyString" }
    user { nil }
  end
end
