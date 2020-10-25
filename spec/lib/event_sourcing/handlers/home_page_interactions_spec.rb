describe EventSourcing::Handlers::HomePageInteractions do
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
      event = EventSourcing::Events::HomePageViewed.new(data: event_data)

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

    it 'only creates a unique visit by ip, user_agent, day' do
      event = EventSourcing::Events::HomePageViewed.new(data: event_data)

      described_class.new.call(event)
      described_class.new.call(event)

      expect(::Analytics::UniqueDailyVisit.count).to eq(1)
    end
  end
end
