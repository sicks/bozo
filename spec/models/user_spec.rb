require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it 'has a valid factory' do
    expect( user.valid? ).to eq true
  end

  it 'is invalid with invalid auths' do
    user.auths.first.provider = nil
    expect( user.valid? ).to eq false
  end
end
