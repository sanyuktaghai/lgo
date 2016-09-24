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
  
end