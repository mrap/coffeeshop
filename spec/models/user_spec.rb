require 'spec_helper'

describe User do
  it { should belong_to(:group).as_inverse_of(:members) }
  it { should have_and_belong_to_many :tags }
  it { should have_many(:messages).as_inverse_of(:author) }
  it { should have_field :username }
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }

  it "should have a random name if no username is given" do
    user = User.create(username: nil)
    user.username.should_not be_nil
  end
end
