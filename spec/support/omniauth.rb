RSpec.configure do |config|
  config.before(:suite) do
    Warden.test_mode!
    OmniAuth.config.test_mode = true
  end

  config.before(:each) do
    OmniAuth.config.mock_auth[:crest] = OmniAuth::AuthHash.new({
      provider: "crest",
      uid: 924610593,
      info: {
        name: "Sicks",
        character_id: 924610593,
        character_owner_hash: "5ZQrqrBJh/Yu6/mdu9GugC549K4="
      }})
  end

  config.after(:each) do
    Warden.test_reset!
    OmniAuth.config.mock_auth[:crest] = nil
  end
end
