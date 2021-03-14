describe Services::CrossPostDevTo do
  let(:post) { create(:post, title: 'bananas', body: "<strong>hi</strong>") }
  let(:default_host) { 'https://www.mockhost.com'}
  let(:base_uri) { 'https://dev.to/api/articles' }
  let(:headers) do
    {
      'Content-Type' => 'application/json',
      'api-key' => 'ABC123'
    }
  end

  let(:payload) do
    {
      "article" => {
        "title"         => post.title,
        "published"     => false,
        "body_markdown" => " **hi** ",
        "tags"          => post.tags.map(&:name),
        "canonical_url" => default_host + "/posts/#{post.friendly_id}"
      }
    }
  end

  describe '.call' do
    xit 'posts with Net::HTTP' do
      request_uri = "/api/articles"
      uri_host = "dev.to"
      uri_port = 443

      expect(Net::HTTP).to receive(:new).with(uri_host, uri_port).and_return(payload)

      described_class.call(post)
    end
  end
end
