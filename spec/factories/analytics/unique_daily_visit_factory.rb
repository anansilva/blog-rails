FactoryBot.define do
  factory :unique_daily_visit, class: Analytics::UniqueDailyVisit do
    day { Date.today }
    visitor_ip { '148.63.78.99' }
    country { 'Portugal' }
    device { 'desktop' }
    referer { 'facebook' }
    user_agent { '' }
  end
end
