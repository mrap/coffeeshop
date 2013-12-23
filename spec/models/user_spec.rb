require 'spec_helper'

describe User do
  it { should belong_to(:group).as_inverse_of(:members) }
end
