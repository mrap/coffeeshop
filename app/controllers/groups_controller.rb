class GroupsController < ApplicationController
  def index
    @groups = Group.most_members
  end

  def show
    @group = Group.find(params[:id])
  end

  def create
    if group = Group.create!(params[:group])
      redirect_to group
    end
  end
end
