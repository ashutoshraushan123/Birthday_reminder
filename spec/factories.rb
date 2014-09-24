FactoryGirl.define do
  factory :department do
   dept Faker::Name.first_name
  end

  factory :team do
   team_name Faker::Name.first_name
  end
end