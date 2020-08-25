module EventSourcing
  module Publishers
    class HomePageViewed
      include ::Services::Callable

      receive :request, :tag_filter

      def result
        ::EventSourcing::PublishService
          .call('home_page_viewed', payload, stream_name: stream_name)
      end

      private

      def stream_name
        return 'all_posts' unless @tag_filter.present?

        @tag_filter.downcase
      end

      def payload
        @payload ||=
          {
            page: @request.original_url,
            visitor_ip: @request.remote_ip,
            user_agent: @request.user_agent,
            referer: @request.referer,
            tag_filter: stream_name
          }
      end
    end
  end
end
