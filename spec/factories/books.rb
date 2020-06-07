FactoryBot.define do
  factory :book do
    
    association :user
    
    title "test_book"
    
    author nil
    
    published nil
    
    thumbnail "http://books.google.com/books/content?id=YnLL1MCtfWcC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api"
    
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
