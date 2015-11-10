FactoryGirl.define do
  factory :sicks_auth, class: OmniAuth::AuthHash do
    skip_create

    provider "crest"
    uid 924610593
    info do
      {
        name: "Sicks",
        character_owner_hash: "5ZQrqrBJh/Yu6/mdu9GugC549K4="
      }
    end
  end

  factory :boki_auth, class: OmniAuth::AuthHash do
    skip_create

    provider "crest"
    uid 2076199677
    info do
      {
        name: "Doctor Boki",
        character_id: 2076199677,
        character_owner_hash: "0ILVMUgY3CU0RSsU4I0oefUR5c4="
      }
    end
  end
end
