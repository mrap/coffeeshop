require 'spec_helper'

describe User do
  it { should have_many(:messages).as_inverse_of(:author).with_dependent(:destroy) }
  it { should have_many(:feature_requests).as_inverse_of(:requester).with_dependent(:destroy) }
  it { should have_many(:votes).as_inverse_of(:voter).with_dependent(:destroy) }
  it { should have_field :username }
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }

  it "should have a random name if no username is given" do
    user = User.create(username: nil)
    user.username.should_not be_nil
  end
end
