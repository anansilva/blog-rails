module EventSourcing
  class PublishService
    include ::Services::Callable

    ALLOWED_EVENTS = {
      home_page_viewed: 'HomePageViewed',
      post_viewed: 'PostViewed'
    }.freeze

    def initialize(type, data, options = {})
      @type = type
      @data = data
      @stream_name = options.fetch(:stream_name, 'all')
    end

    def result
      event = event_klass.new(data: @data)
      event_store.publish(event, stream_name: @stream_name)
    end

    private

    def event_klass
      prefix = 'EventSourcing::Events'
      suffix = ALLOWED_EVENTS[@type.to_sym]

      "::#{prefix}::#{suffix}".constantize
    end

    def event_store
      Rails.configuration.event_store
    end
  end
end
