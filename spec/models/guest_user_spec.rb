require 'spec_helper'


describe GuestUser do
  it { should be_kind_of User }

  it "TEST" do
    GuestUser.create!().should_not be_nil
  end
end

