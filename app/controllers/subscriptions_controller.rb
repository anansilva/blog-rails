class SubscriptionsController < ApplicationController
  def new

  end


  def subscription_params
    params.permit(:email)
  end
end
