require 'spec_helper'

describe FeatureRequestsController do

  describe "POST #create" do
    describe "automatically sets the requester to the current user" do
      let(:create_feature_request)  { post :create, feature_request: { description: "this is my brand new feature request" } }

      context "when current user is guest user" do
        let(:guest_user) { create(:guest_user) }
        before { ApplicationController.any_instance.stub(:current_or_guest_user).and_return(guest_user) }
        it "should set requester to the current user" do
          create_feature_request
          feature_request = FeatureRequest.last
          feature_request.requester.should eq guest_user
        end
      end

      context "when user is a registered user" do
        let(:user)            { create(:user) }
        before { ApplicationController.any_instance.stub(:current_or_guest_user).and_return(user) }
        it "should set requester to the current user" do
          create_feature_request
          feature_request = FeatureRequest.last
          feature_request.requester.should eq user
        end
      end
    end
  end

  describe "POST #upvote and #downvote" do
    let(:feature_request) { create(:feature_request) }
    # Given current user is a guest user
    let(:guest_user) { create(:guest_user) }
    before { ApplicationController.any_instance.stub(:current_or_guest_user).and_return(guest_user) }

    describe "POST #upvote" do
      before { post :upvote, id: feature_request.id }

      it "should corectly upvote the feature request" do
        upvote = feature_request.votes.last
        upvote.is_positive?.should be true
        upvote.voter.should eq guest_user
        upvote.votable.should eq feature_request
      end

      it "should be successful" do
        response.should redirect_to feature_requests_path
      end

    end

    describe "POST #downvote" do
      before { post :downvote, id: feature_request.id }

      it "should corectly downvote the feature request" do
        downvote = feature_request.votes.last
        downvote.is_positive?.should be false
        downvote.voter.should eq guest_user
        downvote.votable.should eq feature_request
      end

      it "should be successful" do
        response.should redirect_to feature_requests_path
      end

    end
  end
end
