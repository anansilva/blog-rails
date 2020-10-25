describe EventSourcing::Handlers::PostInteractions do
  context 'new visit' do
    let(:event_data) do
      {
        page: '',
        visitor_ip: '148.63.78.99',
        user_agent: 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36.',
        referer: 'twitter.com',
      }
    end


    it 'creates a new daily visit' do
      event = EventSourcing::Events::PostViewed.new(data: event_data)

      described_class.new.call(event)

      new_visit = ::Analytics::UniqueDailyVisit.find_by(
        visitor_ip: '148.63.78.99',
        user_agent: event_data[:user_agent],
        country: 'Portugal',
        browser: 'Chrome',
        device: 'desktop',
        referer: 'twitter.com',
        day: Date.today
      )

      expect(new_visit).to be_present
    end
  end

  context 'post views' do
    let(:post) { create(:post, title: 'rspec tips') }
    let(:event_data) do
      {
        page: '',
        visitor_ip: '123.123.123.123',
        user_agent: '',
        referer: '',
        post_id: post.id,
        post_title: post.title
      }
    end


    it 'it starts a new counter on the first view of the post that day by a visitor' do
      event = EventSourcing::Events::PostViewed.new(data: event_data)

      described_class.new.call(event)

      post_counter = ::Analytics::VisitorPostDailyCounter.find_by(
        post_id: post.id,
        visitor_ip: '123.123.123.123',
        day: Date.today
      )

      expect(post_counter.reload.views_count).to eq(1)
    end

    it 'increments the counter every time the visitor views the post on a given day' do
      post_viewed = EventSourcing::Events::PostViewed.new(data: event_data)

      described_class.new.call(post_viewed)
      described_class.new.call(post_viewed)

      post_counter = ::Analytics::VisitorPostDailyCounter.find_by(
        post_id: post.id,
        visitor_ip: '123.123.123.123',
        day: Date.today
      )

      expect(post_counter.reload.views_count).to eq(2)
    end
  end
end

