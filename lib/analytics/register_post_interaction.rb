module Analytics
  class RegisterPostInteraction
    ALLOWED_COUNTERS = {
      post_viewed: 'views_count',
      post_shared: 'shares_count'
    }.freeze

    def initialize(event)
      @event = event
    end

    def self.call(event)
      new(event).result
    end

    def result
      return if me?

      find_or_initialize_counter.tap do |visitor_post_daily_counter|
        visitor_post_daily_counter.update(
          interaction_counter => visitor_post_daily_counter.send(interaction_counter) + 1
        )
      end
    end

    private

    def interaction_counter
      ALLOWED_COUNTERS[event_type.to_sym]
    end

    def event_type
      @event.event_type.split('::').last.underscore
    end

    def find_or_initialize_counter
      ::Analytics::VisitorPostDailyCounter
        .find_or_initialize_by(
          post_id: @event.data[:post_id],
          day: Date.today,
          visitor_ip: @event.data[:visitor_ip]
        )
    end

    def me?
      @event.data[:visitor_ip] == Rails.application.credentials[:ip]
    end
  end
end
