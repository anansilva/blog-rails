describe Services::CrossPostDevTo do
  let(:post) { create(:post, title: 'bananas', body: "<strong>hi</strong>") }
  let(:default_host) { 'https://www.mockhost.com'}
  let(:base_uri) { 'https://www.mockapi.com'}
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
    it 'posts with HTTParty' do
      stub_const("Services::CrossPostDevTo::BASE_URI", base_uri)
      stub_const("Services::CrossPostDevTo::DEFAULT_HOST", default_host)

      allow(Rails.application.credentials).to receive(:dig).and_return('ABC123')

      expect(HTTParty).to receive(:post).with(
        base_uri, { body: payload.to_json, headers: headers }
      )

       described_class.call(post)
    end
  end
end
