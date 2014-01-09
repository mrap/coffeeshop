require 'spec_helper'

describe FeatureRequest do
  it { should belong_to(:requester).of_type(User) }
  it { should have_many(:votes) }
  it { should have_field(:description) }
  it { should have_field :created_at }
  it { should validate_presence_of :requester }
  it { should validate_presence_of :description }
  it { should validate_length_of :description }
end

