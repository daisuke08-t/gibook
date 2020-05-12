FactoryBot.define do
  factory :topic do
    
    title "test"
    
    content nil
    
    author "test"
    
    thumbnail "test"
    
    published "0000"
    
    description "test"
    
    association :user
  end
end
