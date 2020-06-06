FactoryBot.define do
  factory :book do
    
    association :user
    
    title "test_book"
    
    author nil
    
    published nil
    
    thumbnail nil
    
    description nil
    
    content nil
    
    trait :invalid_user_id do
      user_id nil
    end
    
    trait :invalid_title do
      title nil
    end
    
  end
end
