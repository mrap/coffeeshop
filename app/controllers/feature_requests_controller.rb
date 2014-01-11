class FeatureRequestsController < ApplicationController

  before_action :set_feature_request, only: [:upvote, :downvote]

  def index
    @feature_requests = FeatureRequest.all
  end

  def create
    @feature_request = FeatureRequest.new(params[:feature_request])
    @feature_request.requester = current_or_guest_user
    if @feature_request.save
      flash[:success] = I18n.t('flash_success_create_feature_request')
      redirect_to action: :index
    else
      flash[:error] = @feature_request.errors.full_messages.first
      redirect_to action: :index
    end
  end

  def upvote
    vote
  end

  def downvote
    vote(downvote: true)
  end

  protected

    def set_feature_request
      @feature_request = FeatureRequest.find(params[:id])
    end

    def vote(options = {})
      # Remove any previous votes with the this voter and feature request
      # Allows a user to switch a previous vote
      if previous_vote = Vote.where(voter: current_or_guest_user, votable: @feature_request).first
        previous_vote.delete
      end

      if options[:downvote]
        @vote = Vote.new_downvote(votable: @feature_request,
                                   voter: current_or_guest_user)
      else
        @vote = Vote.new_upvote(votable: @feature_request,
                                     voter: current_or_guest_user)
      end

      if @vote.save
        flash[:success] = "Vote successful."
      else
        flash[:error] = @vote.errors.full_messages.first
      end
      redirect_to action: :index
    end

end
