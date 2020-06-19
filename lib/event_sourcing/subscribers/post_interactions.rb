module EventSourcing
  module Subscribers
    class PostInteractions
      def call(event)
        ::Analytics::PostViewCounter.find_or_initialize_by(post_id: event[:post_id]).tap do |post_view_counter|
          post_view_counter.update(count: post_view_counter.count + 1)
        end
      end
    end
  end
end
