module Analytics
  class RegisterDailyVisit
    def initialize(event)
      @event = event
    end

    def self.call(event)
      new(event).result
    end

    def result
      register_visit! unless new_visit.persisted?
    end

    private

    def new_visit
      @new_visit ||=
        ::Analytics::UniqueDailyVisit.find_or_initialize_by(
          visitor_ip: @event.data[:visitor_ip],
          day: Date.today
        )
    end

    def register_visit!
      new_visit.update(
        user_agent: @event.data[:user_agent],
        referer: @event.data[:referer],
        country: country(@event.data[:visitor_ip])['country'],
        browser: browser(@event.data[:user_agent]).name,
        device: device(@event.data[:user_agent])
      )
    end

    def browser(user_agent)
      @browser ||=
        Browser.new(user_agent, accept_language: 'en-us')
    end

    def device(user_agent)
      browser = browser(user_agent)
      return 'mobile' if browser.device.mobile?
      return 'tablet' if browser.device.tablet?

      'desktop'
    end

    def country(request_ip)
      url = URI.parse("http://ip-api.com/json/#{request_ip}")
      request = Net::HTTP::Get.new(url.to_s)
      response = request_ip_parser(url, request)
      JSON.parse(response.body)
    rescue Net::OpenTimeout
      {}
    end

    def request_ip_parser(url, request)
      Net::HTTP.start(url.host, url.port) { |http| http.request(request) }
    end
  end
end
