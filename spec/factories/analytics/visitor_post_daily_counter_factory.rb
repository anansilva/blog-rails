FactoryBot.define do
  factory :visitor_post_daily_counter, class: Analytics::VisitorPostDailyCounter do
    post
    day { Date.today }
    visitor_ip { '148.63.78.99' }
    views_count { 1 }
  end
end
