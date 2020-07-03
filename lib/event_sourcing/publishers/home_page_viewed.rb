module EventSourcing
  module Publishers
    class HomePageViewed
      def initialize(request, tag_filter)
        @request = request
        @tag_filter = tag_filter
      end

      def self.execute!(request, tag_filter)
        new(request, tag_filter).result
      end

      def result
        ::EventSourcing::PublishService
          .execute!('home_page_viewed', payload, stream_name: stream_name)
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
            user_agent: @request.user_agent,
            referer: @request.referer,
            tag_filter: stream_name
          }
      end
    end
  end
end
