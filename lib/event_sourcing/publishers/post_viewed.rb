module EventSourcing
  module Publishers
    class PostViewed
      def initialize(request, post)
        @request = request
        @post = post
      end

      def self.execute!(request, post)
        new(request, post).result
      end

      def result
        ::EventSourcing::PublishService
          .execute!('post_viewed', payload, stream_name: stream_name)
      end

      private

      def stream_name
        "#{@post.id}-#{@post.title.parameterize}"
      end

      def payload
        @payload ||=
          {
            page: @request.original_url,
            user_agent: @request.user_agent,
            referer: @request.referer,
            post_id: @post.id,
            post_title: @post.title.parameterize
          }
      end
    end
  end
end
