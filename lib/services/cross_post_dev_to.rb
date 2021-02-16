module Services
  class CrossPostDevTo
    include ::Services::Callable

    receive :post

    DEFAULT_HOST = "https://www.ananunesdasilva.com".freeze
    BASE_URI = "https://dev.to/api/articles".freeze

    def result
      uri = URI.parse(BASE_URI)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = payload.to_json
      http.request(request)
    end

    private

    def payload
      {
        "article" => {
          "title" => @post.title,
          "published" => false,
          "body_markdown" => body_markdown,
          "tags" => @post.tags.map(&:name),
          "canonical_url" => DEFAULT_HOST + "/posts/#{@post.friendly_id}"
        }
      }
    end

    def body_markdown
      ReverseMarkdown.convert(@post.body.body.to_html)
    end

    def headers
      {
        'Content-Type' => 'application/json',
        'api-key' => Rails.application.credentials.dig(:dev_to, :api_key)
      }
    end
  end
end
