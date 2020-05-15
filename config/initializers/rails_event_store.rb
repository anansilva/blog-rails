Rails.configuration.to_prepare do
  Rails.configuration.event_store = event_store = RailsEventStore::Client.new

  event_store.subscribe(
    ::EventSourcing::Subscribers::HomePageInteractions.new,
      to: [::EventSourcing::Events::HomePageViewed]
  )

  event_store.subscribe(
    ::EventSourcing::Subscribers::PostInteractions.new,
      to: [::EventSourcing::Events::PostViewed]
  )
end
