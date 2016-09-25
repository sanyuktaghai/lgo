FactoryGirl.define do  
  factory :story do
    sequence(:raw_title) { |n| "#{n.ordinalize.capitalize} Story" }
    sequence(:raw_body) { |n| "Body of the #{n.ordinalize} story" }
    user
    
    factory :published_story do
      published true
      sequence(:final_title) { |n| "#{n.ordinalize.capitalize} Final Story" }
    sequence(:final_body) { |n| "Final body of the #{n.ordinalize} story" }
      factory :unpublished_updated_story do
        published false
        sequence(:updated_title) { |n| "#{n.ordinalize.capitalize} Updated Story" }
        sequence(:updated_body) { |n| "Updated body of the #{n.ordinalize} story" }
      end
    end
    
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
    
    factory :user_with_published_stories do
      transient do
        stories_count 1
      end
    
      after(:create) do |user, evaluator|
        create_list(:published_story, evaluator.stories_count, user: user)
      end
    end
    
    factory :user_with_unpublished_updated_stories do
      transient do
        stories_count 1
      end
    
      after(:create) do |user, evaluator|
        create_list(:unpublished_updated_story, evaluator.stories_count, user: user)
      end
    end
    
  end
end