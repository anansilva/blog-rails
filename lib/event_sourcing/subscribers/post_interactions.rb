module EventSourcing
  module Subscribers
    class PostInteractions
      def call(event)
        ::Analytics::RegisterDailyVisit.call(event)

        find_or_initialize_counter(event).tap do |visitor_post_daily_counter|
          visitor_post_daily_counter
            .update(views_count: visitor_post_daily_counter.views_count + 1)
        end
      end

      private

      def find_or_initialize_counter(event)
        ::Analytics::VisitorPostDailyCounter
          .find_or_initialize_by(
            post_id: event.data[:post_id],
            day: Date.today,
            visitor_ip: event.metadata[:request_ip]
          )
      end
    end
  end
end
