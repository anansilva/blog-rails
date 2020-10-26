Rails.configuration.to_prepare do
  Rails.configuration.event_store = event_store = RailsEventStore::Client.new

  event_store.subscribe(
    ::EventSourcing::Handlers::HomePageInteractions.new,
      to: [::EventSourcing::Events::HomePageViewed]
  )

  event_store.subscribe(
    ::EventSourcing::Handlers::PostInteractions.new,
      to: [::EventSourcing::Events::PostViewed,
           ::EventSourcing::Events::PostShared]
  )
end
