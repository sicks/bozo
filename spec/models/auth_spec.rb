require 'rails_helper'

RSpec.describe Auth, type: :model do
  let(:auth) { create(:steam_auth) }

  it 'has a valid factory' do
    expect( auth.valid? ).to eq true
  end

  it 'is invalid without a uid' do
    auth.uid = nil
    expect( auth.valid? ).to eq false
  end

  it 'is invalid without a provider' do
    auth.provider = nil
    expect( auth.valid? ).to eq false
  end

  it 'is invalid without a user' do
    auth.user = nil
    expect( auth.valid? ).to eq false
  end

  it 'is sorted oldest to newest' do
    another_auth = create(:google_auth)
    all_auths = Auth.all

    expect( all_auths.first.created_at ).to be < all_auths.last.created_at
  end
end
