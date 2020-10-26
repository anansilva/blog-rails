module EventSourcing
  class PublishProxy
    include ::Services::Callable

    receive :event_name, :payload, :stream_name

    ALLOWED_EVENTS = {
      home_page_viewed: 'HomePageViewed',
      post_viewed: 'PostViewed',
      post_shared: 'PostShared'
    }.freeze

    def result
      event = event_model.new(data: @payload)
      event_store.publish(event, stream_name: @stream_name || 'all')
    end

    private

    def event_model
      prefix = 'EventSourcing::Events'
      suffix = ALLOWED_EVENTS[@event_name.to_sym]

      "::#{prefix}::#{suffix}".constantize
    end

    def event_store
      Rails.configuration.event_store
    end
  end
end
