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
      
      factory :published_anonymous_story do
        anonymous true
      end
    end
  end

  factory :user, aliases: [:author, :poster] do
    sequence(:email) { |n| "test#{n}@example.com" }
    password 'password'
    sequence(:first_name) { |n| "Jane{n}" }
    sequence(:last_name) { |n| "Doe{n}" }
    
    factory :admin do
      admin true
    end
    
    factory :anonymous_user do
      email "anonymous@example.com"
    end
    
    factory :user_with_unpublished_stories do
      transient do
        stories_count 1
      end
    
      after(:create) do |user, evaluator|
        create_list(:story, evaluator.stories_count, user: user, author_id: user.id)
      end
    end
    
    factory :user_with_published_stories do
      transient do
        stories_count 1
      end
    
      after(:create) do |user, evaluator|
        create_list(:published_story, evaluator.stories_count, user: user, author_id: user.id)
      end
    end
    
    factory :user_with_published_anonymous_stories do
      transient do
        stories_count 1
      end
    
      after(:create) do |user, evaluator|
        create_list(:published_anonymous_story, evaluator.stories_count, user: user, author_id: user.id, poster_id: 1000)
      end
    end
    
    factory :user_with_unpublished_updated_stories do
      transient do
        stories_count 1
      end
    
      after(:create) do |user, evaluator|
        create_list(:unpublished_updated_story, evaluator.stories_count, author_id: user.id)
      end
    end
    
  end
end