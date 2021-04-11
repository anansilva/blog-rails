require 'webmock/rspec'

describe SubscriptionsController do
  describe '#new' do
    before do
      allow(Services::NewSubscriber).to receive(:new).and_return({})

      post :new
    end

    it 'calls the NewSubscriber service' do
      expect(Services::NewSubscriber).to have_received(:new)
    end
  end
end
