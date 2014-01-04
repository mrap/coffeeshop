class GroupsController < ApplicationController

  before_action :set_group, only: [:show]

  def index
    @groups = Group.most_members
  end

  def search
    @groups = Group.full_text_search(params[:search])
    render :index
  end

  def show
    @group.add_member(current_or_guest_user)
    gon.group = @group
  end

  def create
    if group = Group.create!(params[:group])
      redirect_to group
    end
  end

  private

    def set_group
      @group = Group.find(params[:id])
    end

end
