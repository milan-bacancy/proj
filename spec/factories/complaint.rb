FactoryBot.define do
    factory :complaint do
        title { Faker::Lorem.word }
        desc { Faker::Lorem.sentence }
        status { "ongoing" }
    end
  end