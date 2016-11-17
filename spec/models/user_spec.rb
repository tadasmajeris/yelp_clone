require 'rails_helper'

describe User do
  context 'User should have reviewed many restaurants' do
    it { is_expected.to have_many :reviewed_restaurants }
  end 
end
