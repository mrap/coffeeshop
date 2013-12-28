require 'spec_helper'

describe GroupsController do
  describe 'GET #index' do
    it "should be successful" do
      get :index
      response.should be_successful
    end

    it "loads all groups into @groups ordered by members" do
      get :index
      assigns(:groups).should eq Group.most_members
    end
  end

  describe 'GET #show' do
    let(:group)         { create(:group) }
    let(:current_user)  { create(:user) }

    it "should be successful" do
      get :show, id: group.id
      response.should be_successful
    end

    it "puts adds the current_user as a member" do
      ApplicationController.any_instance.stub(:current_user).and_return(current_user)
      get :show, id: group.id
      group.members.should include current_user
    end
  end

  describe 'POST #create' do
    it "should be successful" do
      post :create, group: { name: "Programming" }
      group = Group.where(name: "Programming").first
      response.should redirect_to group_path(group.id)
    end
  end
end
