FactoryGirl.define do
  factory :map do
    title "Iso5 Home"
    corp { create(:user_sicks).corps.first }
    home { System.find(1589) }
  end
end
