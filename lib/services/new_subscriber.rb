module Services
  class NewSubscriber

    BASE_URI = "https://api.buttondown.email/v1/subscribers".freeze

    def initialize(email, referrer_url, **options)
      @email = email
      @referrer_url = referrer_url
      @notes = options[:notes] || ''
      @tags = options[:tags] || []
      @metadata = options[:metadata] || {}
    end

    def register!
      uri = URI.parse(BASE_URI)
      request = Net::HTTP::Post.new(uri.request_uri, headers)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.request(request, payload.to_json)
    end

    private

    def payload
      {
        "email" => @email,
        "metadata" => @metadata,
        "notes" => @notes,
        "referrer_url" => @referrer_url,
        "tags" => @tags
      }
    end

    def headers
      {
        'Content-Type' => 'application/json',
        'api-key' => Rails.application.credentials.dig(:buttondown, :api_key)
      }
    end
  end
end
