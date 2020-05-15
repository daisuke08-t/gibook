FactoryBot.define do
  factory :favorite do
    
    association :user
    
    association :topic
    
  end
end
