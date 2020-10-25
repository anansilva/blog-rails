module EventSourcing
  module Publishers
    class PostShared
      include ::Services::Callable

      receive :request, :post

      def result
        ::EventSourcing::PublishProxy
          .call('post_shared', payload, stream_name)
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
            post_id: @post.id,
            post_title: @post.title.parameterize
          }
      end
    end
  end
end
