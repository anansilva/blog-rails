module Services
  class CrossPostDevTo
    include ::Services::Callable

    receive :post

    DEFAULT_HOST = "https://www.ananunesdasilva.com".freeze
    BASE_URI = "https://dev.to/api/articles".freeze

    def result
      uri = URI.parse(BASE_URI)
      request = Net::HTTP::Post.new(uri.request_uri, headers)


      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.request(request, payload.to_json)
    end

    private

    def payload
      {
        "article" => {
          "title" => @post.title,
          "published" => false,
          "body_markdown" => @post.body,
          "tags" => @post.tags.map(&:name),
          "canonical_url" => DEFAULT_HOST + "/posts/#{@post.friendly_id}"
        }
      }
    end

    def headers
      {
        'Content-Type' => 'application/json',
        'api-key' => Rails.application.credentials.dig(:dev_to, :api_key)
      }
    end
  end
end
