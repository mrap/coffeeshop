class FeatureRequestsController < ApplicationController

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

end
