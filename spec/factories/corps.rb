FactoryGirl.define do
  factory :corp_iso, class: Corp do
    ccp_id 98297019
    name "Isogen 5"
  end

  factory :corp_dg3n, class: Corp do
    ccp_id 1262577328
    name "Doom Generation"
  end
end
