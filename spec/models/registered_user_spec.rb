require 'spec_helper'

describe RegisteredUser do
  it { should be_kind_of User }

  subject(:registered_user) { create(:registered_user) }
  it { should_not be_nil }
end
