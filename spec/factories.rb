FactoryGirl.define do  
  
  factory :bookmark do
    user nil
    story nil
  end
  
  factory :story_like do
    user nil
    story nil
  end

  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password 'password'
    
    factory :admin do
      admin true
    end  
  end  
  
  factory :story do
    sequence(:raw_title) { |n| "#{n.ordinalize.capitalize} Story" }
    sequence(:raw_body) { |n| "Body of the #{n.ordinalize} story" }
#    user 
  end
  
end