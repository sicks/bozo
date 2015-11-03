RSpec.configure do |config|
  config.before(:suite) do
    Warden.test_mode!
    OmniAuth.config.test_mode = true
  end

  config.after(:each) do
    Warden.test_reset!
    OmniAuth.config.mock_auth[:google_oauth2] = nil
    OmniAuth.config.mock_auth[:steam] = nil
  end
end
