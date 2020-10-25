module EventSourcing
  module Publishers
    class PostViewed
      include ::Services::Callable

      receive :request, :post

      def result
        ::EventSourcing::PublishService
          .call('post_viewed', payload, stream_name)
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
            visitor_ip: @request.remote_ip,
            referer: @request.referer,
            post_id: @post.id,
            post_title: @post.title.parameterize
          }
      end
    end
  end
end
