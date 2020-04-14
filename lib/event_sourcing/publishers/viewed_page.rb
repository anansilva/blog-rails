module EventSourcing
  module Publishers
    class ViewedPage
      def initialize(request)
        @request = request
      end

      def self.execute!(request)
        new(request).result
      end

      def result
        ::EventSourcing::PublishService.execute!('viewed_page', payload, stream_name: 'posts')
      end

      private

      def payload
        @payload ||=
          {
            page: @request.original_url,
            ip_address: @request.remote_ip,
            user_agent: @request.user_agent,
            referer: @request.referer
          }
      end
    end
  end
end
