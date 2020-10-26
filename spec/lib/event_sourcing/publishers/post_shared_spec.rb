describe EventSourcing::Publishers::PostShared do
  let(:post) { build_stubbed(:post, title: 'post title') }

  it 'calls PublishService with the right payload' do
    Request = Struct.new(:original_url, :remote_ip, :user_agent, :referer)

    request = Request.new("http://test.host/",
                          '0.0.0.0',
                          'Rails Testing',
                          'www.linkedin.com')

    expected_payload = {
      page: "http://test.host/",
      visitor_ip: "0.0.0.0",
      user_agent: 'Rails Testing',
      referer: 'www.linkedin.com',
      post_id: post.id,
      post_title: 'post-title',
      social_media: 'twitter',
    }

    expect(::EventSourcing::PublishProxy).to receive(:call)
      .with('post_shared', expected_payload, "twitter-#{post.id}-post-title")

    described_class.call(request, post, 'twitter')
  end
end
