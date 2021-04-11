require 'webmock/rspec'

describe SubscriptionsController do
  describe '#new' do
    it 'calls the NewSubscriber service' do
      expect(Services::NewSubscriber).to receive_message_chain(:new, :register!)

      post :new
    end
  end
end
