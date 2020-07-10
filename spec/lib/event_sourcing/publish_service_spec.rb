describe EventSourcing::PublishService do
  let(:event_store) { Rails.configuration.event_store }
  let(:data) do
    { page: 'all posts',
      user_agent: ''
    }
  end

  describe '#execute' do
    it 'increments the number of events by 1' do
      described_class.call('home_page_viewed', data, stream_name: 'all-posts')

      expect(event_store.read.count).to eq(1)
      expect(event_store.read.stream('all-posts').count).to eq(1)
    end

    it 'publishes the event with the right data' do
      described_class.call('home_page_viewed', data, stream_name: 'all-posts')

      published_event = event_store.read.first

      expect(published_event.event_type).to eq('EventSourcing::Events::HomePageViewed')
      expect(published_event.data[:page]).to eq('all posts')
    end
  end
end
