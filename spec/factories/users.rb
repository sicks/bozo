FactoryGirl.define do
  factory :user do
    after(:create) do |user|
      user.chars.create( attributes_for :crest_char )
    end
  end

  factory :user_sicks, class: User do
    after(:create) do |user|
      user.chars.create( attributes_for :crest_sicks )
    end
  end
end
