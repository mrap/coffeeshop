require 'spec_helper'

describe User do
  it { should belong_to(:group).as_inverse_of(:members) }
  it { should have_and_belong_to_many :tags }
end
