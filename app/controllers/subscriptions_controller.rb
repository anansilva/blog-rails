class SubscriptionsController < ApplicationController
  def new
    ::Services::NewSubscriber.new(
      subscription_params[:email],
      referrer_url)
  end

  private

  def referrer_url
    request.url
  end

  def subscription_params
    params.permit(:email)
  end
end
