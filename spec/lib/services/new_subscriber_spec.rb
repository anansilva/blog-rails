require 'webmock/rspec'

describe Services::NewSubscriber do
  let(:email) { 'user@example.com' }
  let(:referrer_url) { 'www.blog.com' }
  let(:tags) { ['blog'] }
  let(:options) { { tags: tags, notes: '', metadata: {} } }

  let(:payload) do
    {
      "email": email,
      "metadata": {},
      "notes": "",
      "referrer_url": referrer_url,
      "tags": tags
    }
  end

  let(:base_uri) { "https://api.buttondown.email/v1/subscribers" }

  let(:headers) do
    {
      'Content-Type' => 'application/json',
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
    }
  end

  describe '#register!' do
    let(:response_body) { File.open('./spec/fixtures/buttondown_response_body.json') }

    it 'sends a post request to the buttondown API' do
      stub_request(:post, base_uri)
        .with(body: payload.to_json, headers: headers)
        .to_return( body: response_body, status: 201, headers: headers)

      response = described_class.new(email: 'user@example.com', referrer_url: referrer_url, **options).register!

      expect(response.code).to eq("201")
    end
  end
end
