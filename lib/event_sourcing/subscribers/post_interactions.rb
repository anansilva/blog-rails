module EventSourcing
  module Subscribers
    class PostInteractions
      def call(event)
        ::Analytics::RegisterDailyVisit.call(event)

        ::Analytics::RegisterPostInteraction.call(event)
      end
    end
  end
end
