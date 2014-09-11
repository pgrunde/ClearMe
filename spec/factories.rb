FactoryGirl.define do
  factory :inhouse_user do
    email "peter.a.grunde@gmail.com"
    username "pgrunde"
    password "password"
  end

  factory :external_user do
    email "peter.a.grunde@gmail.com"
    username "pgrunde"
    password "password"
  end
end
