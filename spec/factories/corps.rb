FactoryGirl.define do
  factory :corp_iso, class: Corp do
    ccp_id 98297019
    name "Isogen 5"

    initialize_with { Corp.find_or_create_by(ccp_id: ccp_id, name: name) }
  end

  factory :corp_dg3n, class: Corp do
    ccp_id 1262577328
    name "Doom Generation"

    initialize_with { Corp.find_or_create_by(ccp_id: ccp_id, name: name) }
  end
end
