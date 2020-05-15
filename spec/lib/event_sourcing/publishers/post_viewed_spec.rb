describe EventSourcing::Publishers::PostViewed do
  let(:post) { build_stubbed(:post, title: 'post title') }

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
      referer: 'www.twitter.com',
      post_id: post.id,
      post_title: 'post-title'
    }

    allow(::EventSourcing::PublishService).to receive(:execute!)
      .with('post_viewed', expected_payload, stream_name: "#{post.id}-post-title")

    described_class.execute!(request, post)

    expect(::EventSourcing::PublishService).to have_received(:execute!)
      .with('post_viewed', expected_payload, stream_name: "#{post.id}-post-title")
  end
end
