module EventSourcing
  module Subscribers
    class HomePageInteractions
      def call(event)
        ::Analytics::RegisterDailyVisit.call(event)
      end
    end
  end
end
