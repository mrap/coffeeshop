require 'spec_helper'

describe MessagesController do
  let(:group) { create(:group) }

  describe "GET #index" do
    it "should redirect to group" do
      get :index, group_id: group.id
      response.should redirect_to group
    end
  end

  describe "POST create" do
    let(:create_message)  { post :create, group_id: group.id, message: { content: "my message" } }

    context "when user is guest user" do
      let(:guest_user)            { create(:guest_user) }
      before { ApplicationController.any_instance.stub(:current_or_guest_user).and_return(guest_user) }
      it "should set message author to the current user" do
        create_message
        message = Message.last
        message.author.should eq guest_user
      end
    end

    context "when user is a registered user" do
      let(:user)            { create(:user) }
      before { ApplicationController.any_instance.stub(:current_or_guest_user).and_return(user) }
      it "should set message author to the current user" do
        create_message
        message = Message.last
        message.author.should eq user
      end
    end

    it "should redirect to group" do
      create_message
      response.should redirect_to group
    end
  end

end
