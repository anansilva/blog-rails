class SubscriptionsController < ApplicationController
  def new
    ::Services::NewSubscriber
      .new(email: subscription_params[:email], referrer_url: referrer_url)
      .register!
  end

  private

  def referrer_url
    request.url
  end

  def subscription_params
    params.permit(:email)
  end
end
