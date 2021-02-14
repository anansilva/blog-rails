module Services
  class CrossPostDevTo
    include ::Services::Callable
    include HTTParty

    receive :post

    DEFAULT_HOST = "https://ananunesdasilva.com".freeze
    BASE_URI = "https://dev.to/api/articles".freeze

    def result
      HTTParty.post(BASE_URI, { body: payload.to_json, headers: headers })
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
