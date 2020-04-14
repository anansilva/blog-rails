describe EventSourcing::PublishService do
  let(:event_store) { Rails.configuration.event_store }
  let(:data) { { page: 'all posts' } }

  describe '#execute' do
    it 'increments the number of events by 1' do
      described_class.execute!('viewed_page', data, stream_name: 'posts')

      expect(event_store.read.count).to eq(1)
      expect(event_store.read.stream('posts').count).to eq(1)
    end

    it 'publishes the event with the right data' do
      described_class.execute!('viewed_page', data, stream_name: 'posts')

      published_event = event_store.read.first

      expect(published_event.type).to eq('EventSourcing::Events::ViewedPage')
      expect(published_event.data[:page]).to eq('all posts')
    end
  end
end
