FactoryBot.define do
  factory :user, aliases: [:owner] do
    
    name "tester"
    
    sequence(:email) { |n| "tester#{n}@example.com" }
    
    password "tester0000"
    
    icon nil
    
    content nil
    
    remember_digest nil
  end
  
end
