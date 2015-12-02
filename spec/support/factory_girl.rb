RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  DatabaseCleaner.strategy = :transaction
end
