describe EventSourcing::Publishers::PageViewed do
  it 'calls PublishService with the right payload' do
    Request = Struct.new(:original_url, :remote_ip, :user_agent, :referer)

    request = Request.new("http://test.host/",
                          '0.0.0.0',
                          'Rails Testing',
                          'www.twitter.com')

    expected_payload = {
      page: "http://test.host/",
      ip_address: '0.0.0.0',
      user_agent: 'Rails Testing',
      referer: 'www.twitter.com'
    }

    allow(::EventSourcing::PublishService).to receive(:execute!)
      .with('page_viewed', expected_payload, stream_name: 'posts')

    described_class.execute!(request, 'posts')

    expect(::EventSourcing::PublishService).to have_received(:execute!)
      .with('page_viewed', expected_payload, stream_name: 'posts')
  end
end
