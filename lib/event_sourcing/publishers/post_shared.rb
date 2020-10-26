module EventSourcing
  module Publishers
    class PostShared
      include ::Services::Callable

      receive :request, :post, :social_media

      def result
        ::EventSourcing::PublishProxy
          .call('post_shared', payload, stream_name)
      end

      private

      def stream_name
        "#{@social_media}-#{@post.id}-#{@post.title.parameterize}"
      end

      def payload
        @payload ||=
          {
            page: @request.original_url,
            user_agent: @request.user_agent,
            visitor_ip: @request.remote_ip,
            referer: @request.referer,
            post_id: @post.id,
            post_title: @post.title.parameterize,
            social_media: @social_media
          }
      end
    end
  end
end
