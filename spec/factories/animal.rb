FactoryGirl.define do
  factory :animal do
    nome Faker::Name.name
    peso Faker::Number.number(2)
    especie 'arara'
    data_registro Faker::Time.backward(30)
    data_saida Faker::Time.backward(2)

    trait :datas_invalidas do
      data_registro Date.today
      data_saida Date.yesterday
    end

  end
end
