describe EventSourcing::Publishers::HomePageViewed do
  it 'calls PublishService with the right payload' do
    HomeRequest = Struct.new(:original_url, :remote_ip, :user_agent, :referer)

    request = HomeRequest.new("http://test.host/",
                          '0.0.0.0',
                          'Rails Testing',
                          'www.twitter.com')

    expected_payload = {
      page: "http://test.host/",
      ip_address: '0.0.0.0',
      user_agent: 'Rails Testing',
      referer: 'www.twitter.com',
      tag_filter: 'performance'
    }

    allow(::EventSourcing::PublishService).to receive(:execute!)
      .with('home_page_viewed', expected_payload, stream_name: 'performance')

    described_class.execute!(request, 'performance')

    expect(::EventSourcing::PublishService).to have_received(:execute!)
      .with('home_page_viewed', expected_payload, stream_name: 'performance')
  end
end
