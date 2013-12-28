require 'spec_helper'

describe UnregisteredUser do
  it { should be_kind_of User }
  it { should have_field :token }
  it { should validate_presence_of :token }
  it { should validate_uniqueness_of :token }

  subject(:unregistered_user) { create(:unregistered_user) }

  it { should_not be_nil }

  it "should have a random name upon creation" do
    user = UnregisteredUser.create
    user.username.should_not be_nil
  end

end
