require 'rails_helper'

RSpec.describe "All Factories" do
  specify "pass linting" do
    FactoryGirl.lint
  end
end
