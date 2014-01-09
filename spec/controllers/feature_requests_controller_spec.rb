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
end
