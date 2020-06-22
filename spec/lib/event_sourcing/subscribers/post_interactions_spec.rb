describe EventSourcing::Subscribers::PostInteractions do
  context 'post views' do
    let(:post) { create(:post, title: 'rspec tips') }
    let(:event_data) do
      {
        page: '',
        user_agent: '',
        referer: '',
        post_id: post.id,
        post_title: post.title
      }
    end

    let(:event_metadata) { { request_ip: '123.123.123.123' } }

    it 'it starts a new counter on the first view of the post that day by a visitor' do
      event = EventSourcing::Events::PostViewed.new(data: event_data,
                                                    metadata: event_metadata)

      described_class.new.call(event)

      post_counter = ::Analytics::VisitorPostDailyCounter.find_by(
        post_id: post.id,
        visitor_ip: '123.123.123.123',
        day: Date.today
      )

      expect(post_counter.reload.views_count).to eq(1)
    end

    it 'increments the counter every time the visitor views the post on a given day' do
      post_viewed = EventSourcing::Events::PostViewed.new(data: event_data,
                                                              metadata: event_metadata)

      described_class.new.call(post_viewed)
      described_class.new.call(post_viewed)

      post_counter = ::Analytics::VisitorPostDailyCounter.find_by(
        post_id: post.id,
        visitor_ip: '123.123.123.123',
        day: Date.today
      )

      expect(post_counter.reload.views_count).to eq(2)
    end

    xit 'starts a new counter on the next day' do
    end
  end
end

