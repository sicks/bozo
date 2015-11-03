FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "example#{n}" }

    after(:create) do |user|
      user.auths.create( attributes_for :steam_auth )
      user.auths.create( attributes_for :google_auth )
    end
  end
end
