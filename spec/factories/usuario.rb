FactoryGirl.define do
  factory :usuario do
    nome Faker::Name.name
    sequence(:email) { |n| "email#{n}@exemplo.com" }
    senha Faker::Lorem.characters(8)
    data_registro Date.yesterday
    data_desligamento Date.today
    perfil 'administrador'

    trait :datas_invalidas do
      data_registro Date.today
      data_desligamento Date.yesterday
    end
  end
end
