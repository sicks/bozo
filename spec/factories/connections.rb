FactoryGirl.define do
  factory :direct_lowsec_connection, class: Connection do
    map
    from { System.find_by_name("Decon") }
    to   { System.find_by_name("J111518") }
    hole { Hole.find_by_name("C140") }
    eol false
    stage 1
  end
end
