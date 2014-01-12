require 'spec_helper'

describe User do
  it { should have_many(:messages).as_inverse_of(:author).with_dependent(:destroy) }
  it { should have_many(:feature_requests).as_inverse_of(:requester).with_dependent(:destroy) }
  it { should have_many(:votes).as_inverse_of(:voter).with_dependent(:destroy) }
  it { should belong_to(:shop).as_inverse_of(:owner) }
  it { should belong_to(:barista_shop).of_type(Shop).as_inverse_of(:barista) }
  it { should belong_to(:patron_shop).of_type(Shop).as_inverse_of(:patron) }

  it { should have_field :username }
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }

  it "should have a random name if no username is given" do
    user = User.create(username: nil)
    user.username.should_not be_nil
  end
end
