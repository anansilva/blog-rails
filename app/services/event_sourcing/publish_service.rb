module EventSourcing
  class PublishService
    ALLOWED_EVENTS = {
      viewed_page: 'ViewedPage'
    }.freeze

    def initialize(type, data, stream_name)
      @type = type
      @data = data
      @stream_name = stream_name
    end

    def self.execute!(type, data, stream_name)
      new(type, data, stream_name).publish
    end

    def publish
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
