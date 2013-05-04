# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :thought, :class => 'Thoughts' do
    detail "MyText"
  end
end
