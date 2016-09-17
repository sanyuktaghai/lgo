FactoryGirl.define do  factory :story_like do
    user nil
story nil
  end

  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password 'password'
  end  
  
end