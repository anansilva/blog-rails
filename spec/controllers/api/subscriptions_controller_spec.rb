require 'webmock/rspec'

describe Api::SubscriptionsController do
  let(:email) { 'user@example.com' }
  let(:tags) { [] }
  let(:options) { { tags: tags, notes: '', metadata: {} } }

  let(:payload) do
    {
      "email": email,
      "metadata": {},
      "notes": "",
      "referrer_url": 'http://test.host/api/subscriptions/register',
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

  let(:response_body) { File.open('./spec/fixtures/buttondown_response_body.json') }

  describe '#register' do
    before do
      stub_request(:post, base_uri)
        .with(body: payload.to_json, headers: headers)
        .to_return( body: response_body, status: 201, headers: headers)
    end

    context 'email is valid' do
      it 'renders a success message' do
        post :register, params: { email: email }

        expect(JSON.parse(response.body)['message']).to include('Thanks')
      end
    end

    context 'email is invalid' do
      before do
        stub_request(:post, base_uri)
          .with(body: payload.to_json, headers: headers)
          .to_return( body: '', status: 400, headers: headers)
      end

      it 'renders an error message' do
        post :register, params: { email: email }

        expect(JSON.parse(response.body)['message']).to include('Error subscribing')
      end
    end
  end
end
