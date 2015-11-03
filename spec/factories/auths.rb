FactoryGirl.define do
  factory :google_auth, class: Auth do
    provider "google_oauth2"
    uid "12345678"
    association :user
  end

  factory :steam_auth, class: Auth do
    provider "steam"
    uid "87654321"
    association :user
  end
end
