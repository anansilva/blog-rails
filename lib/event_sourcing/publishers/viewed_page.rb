module EventSourcing
  module Publishers
    class ViewedPage
      def initialize(request, stream_name)
        @request = request
        @stream_name = stream_name
      end

      def self.execute!(request, stream_name = nil)
        new(request, stream_name).result
      end

      def result
        ::EventSourcing::PublishService.execute!('viewed_page', payload, stream_name: @stream_name)
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
