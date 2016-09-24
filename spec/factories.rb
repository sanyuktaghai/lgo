FactoryGirl.define do  
  factory :story do
    sequence(:raw_title) { |n| "#{n.ordinalize.capitalize} Story" }
    sequence(:raw_body) { |n| "Body of the #{n.ordinalize} story" }
    user
  end

  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password 'password'
    
    factory :admin do
      admin true
    end
    
    factory :user_with_stories do
      transient do
        stories_count 1
      end
    
      after(:create) do |user, evaluator|
        create_list(:story, evaluator.stories_count, user: user)
      end
    end  
  end
end