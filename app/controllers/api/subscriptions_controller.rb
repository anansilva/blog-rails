class Api::SubscriptionsController < ApplicationController
  def register
    new_subscription = ::Services::NewSubscriber
      .new(email: subscription_params[:email], referrer_url: referrer_url)
      .register!

    if successfull?(new_subscription)
      render json: { status: 201, message: success_message }, status: 200
    else
      render json: { status: 400, message: error_message }, status: 400
    end
  end

  private

  def successfull?(subscription)
    subscription.code_type == Net::HTTPCreated
  end

  def success_message
    'Thanks! You\'ll receive an email to confirm your subscription.'
  end

  def error_message
    'Error subscribing. Please try again with a valid email.'
  end

  def referrer_url
    request.url
  end

  def subscription_params
    params.permit(:email)
  end
end
