FactoryGirl.define do
  factory :usuario do
    nome Faker::Name.name
    sequence(:email) { |n| "email#{n}@exemplo.com" }
    password Faker::Lorem.characters(8)
    data_registro Date.today - 5
    data_desligamento Date.today
    perfil 'administrador'
    # confirmed_at Time.now

    trait :admin do
      perfil 'administrador'
    end

    trait :atendente do
      perfil 'atendente'
    end

    trait :datas_invalidas do
      data_registro Date.today
      data_desligamento Date.yesterday
    end
  end
end
