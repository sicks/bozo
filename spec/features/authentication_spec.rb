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
        click_button 'submit'

        expect( page ).to have_content "Registration Successful"
        expect( page ).to have_content "banana"
      end
    end
  end

  describe 'Existing users can sign in' do
    let!(:user) { create(:user) }

    %w[google steam].each do |strategy|
      scenario "with #{strategy}" do
        visit '/'
        click_link 'login'
        click_link strategy

        expect( page ).to have_content "Successfully authenticated"
        expect( page ).to have_content user.username
      end
    end
  end

  context 'Signed in Users' do
    let!(:user) { create(:user) }

    def log_in
      visit '/'
      click_link 'login'
      click_link 'steam'
    end

    describe 'Users with only one auth' do
      before(:each) do
        user.auths.offset(1).destroy_all
        log_in
      end

      scenario 'cannot delete their only auth' do
        click_link user.username
        click_link 'account'
        expect( page ).to_not have_button "delete #{user.auths.first.name} auth"
      end

      scenario 'can add another auth' do
        click_link user.username
        click_link 'account'
        click_link 'add google auth'
        expect( page ).to have_content "New Google Auth successfully added"
      end
    end

    describe 'Users with more than one auth' do
      before(:each) do
        visit '/'
        click_link 'login'
        click_link 'steam'
      end

      %w[google steam].each do |strategy|
        scenario "can delete their #{strategy} auth" do
          click_link user.username
          click_link 'account'
          click_button "delete #{strategy} auth"
          expect( page ).to have_content "#{strategy.humanize} Auth Deleted"
        end
      end
    end
  end
end
