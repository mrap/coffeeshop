require 'spec_helper'

describe Vote do
  it { should belong_to(:votable).with_polymorphism }
  it { should belong_to(:voter).of_type(User) }
  it { should have_field(:is_positive?).of_type(Boolean).with_default_value_of(true) }

  it { should validate_presence_of :votable }
  it { should validate_presence_of :voter }
  it { should validate_uniqueness_of(:voter).scoped_to(:votable) }

  describe "upvote and downvote helper constructors" do
    let(:voter)    { create(:user) }
    let(:votable)  { create(:feature_request) }

    describe "self.create_upvote" do
      it "creates an upvote" do
        vote = Vote.create_upvote(voter: voter, votable: votable)
        vote.is_positive?.should be_true
      end
    end

    describe "self.create_downvote" do
      it "creates a downvote" do
        vote = Vote.create_downvote(voter: voter, votable: votable)
        vote.is_positive?.should be_false
      end
    end
  end

  # Vote.total_for(votable)
  # This is not a truly polymorphic spec.
  describe "self.total_for(votable)" do
    let(:feature_request) { create(:feature_request) }

    before do
      # 2 upvotes + 1 downvote = 1 total
      create_list(:upvote, 2, votable: feature_request)
      create(:downvote, votable: feature_request)
    end

    it "returns the sum total of positive and negative votes" do
      Vote.total_for(feature_request).should eq 1
    end
  end

end
