require 'webmock/rspec'

describe Services::CrossPostDevTo do
  let(:post) { create(:post, title: 'bananas', body: "**hi**") }
  let(:base_uri) { 'https://dev.to/api/articles' }
  let(:default_host) { 'https://www.ananunesdasilva.com' }
  let(:headers) do
    {
      'Content-Type' => 'application/json',
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
    }
  end

  let(:payload) do
    {
      "article" => {
        "title"         => post.title,
        "published"     => false,
        "body_markdown" => post.body,
        "tags"          => post.tags.map(&:name),
        "canonical_url" => default_host + "/posts/#{post.friendly_id}"
      }
    }
  end

  describe '.call' do
    it 'sends a post request to the dev to api' do
      stub_request(:post, base_uri)
        .with(body: payload.to_json, headers: headers)
        .to_return(body: File.open('./spec/fixtures/dev_to_response_body.json'), status: 201, headers: headers)

       response = described_class.call(post)

       expect(response.code).to eq('201')
    end
  end
end
