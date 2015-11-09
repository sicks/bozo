FactoryGirl.define do
  factory :crest_char, class: Char do
    provider "crest"
    sequence(:uid) {|n| n }
    sequence(:name) {|n| "Sicks #{n}"}
    sequence(:ccp_id) { |n| n }
    sequence(:owner) {|n| "asjkdfhlaskdjfhasd#{n}" }
    user
  end

  factory :crest_sicks, class: Char do
    provider "crest"
    uid 924610593.to_s
    name "Sicks"
    ccp_id 924610593
    owner "5ZQrqrBJh/Yu6/mdu9GugC549K4="
    user
  end
end
