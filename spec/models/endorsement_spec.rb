require 'rails_helper'

describe Endorsement, type: :model do

  it { is_expected.to have_one :reviewed_restaurants}

end
