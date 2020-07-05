describe EventSourcing::Publishers::HomePageViewed do
  it 'calls PublishService with the right payload' do
    HomeRequest = Struct.new(:original_url, :user_agent, :referer)

    request = HomeRequest.new("http://test.host/",
                          'Rails Testing',
                          'www.twitter.com')

    expected_payload = {
      page: "http://test.host/",
      user_agent: 'Rails Testing',
      referer: 'www.twitter.com',
      tag_filter: 'performance'
    }

    allow(::EventSourcing::PublishService).to receive(:call)
      .with('home_page_viewed', expected_payload, stream_name: 'performance')

    described_class.call(request, 'performance')

    expect(::EventSourcing::PublishService).to have_received(:call)
      .with('home_page_viewed', expected_payload, stream_name: 'performance')
  end
end
