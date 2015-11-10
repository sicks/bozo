RSpec.configure do |config|
  config.before(:suite) do
    Warden.test_mode!
    OmniAuth.config.test_mode = true
  end

  config.before(:each) do
    OmniAuth.config.mock_auth[:crest] = OmniAuth::AuthHash.new( attributes_for(:sicks_auth) )
  end

  config.after(:each) do
    Warden.test_reset!
    OmniAuth.config.mock_auth[:crest] = nil
  end

  def reset_auth( auth )
    OmniAuth.config.mock_auth[:crest] = OmniAuth::AuthHash.new( attributes_for( auth ) )
  end
end
