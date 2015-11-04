require 'rails_helper'

RSpec.describe 'Feature: User Authentication', type: :feature do
  describe 'New users can register' do
    before(:each) do
      User.destroy_all
    end

    %w[google steam].each do |strategy|
      scenario "with #{strategy}" do
        visit '/'
        click_link 'login'
        click_link strategy
        fill_in 'user_username', with: "banana"
        click_button 'Create User'

        expect( page ).to have_content "Registration Successful"
        expect( page ).to have_content "banana"
      end
    end
  end
end
