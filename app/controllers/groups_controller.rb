class GroupsController < ApplicationController
  def index
    @groups = Group.most_members
  end

  def show
    @group = Group.find(params[:id])
  end
end
