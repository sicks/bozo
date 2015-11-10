FactoryGirl.define do
  factory :char, class: Char do
    provider "crest"
    sequence(:uid) {|n| n }
    sequence(:name) {|n| "Sicks #{n}"}
    sequence(:owner) {|n| "asjkdfhlaskdjfhasd#{n}" }
    user
  end

  factory :char_sicks, class: Char do
    provider "crest"
    uid 924610593
    name "Sicks"
    owner "5ZQrqrBJh/Yu6/mdu9GugC549K4="
    user
  end

  factory :char_boki, class: Char do
    provider "crest"
    uid 2076199677
    name "Doctor Boki"
    owner "0ILVMUgY3CU0RSsU4I0oefUR5c4="
    user
  end
end
