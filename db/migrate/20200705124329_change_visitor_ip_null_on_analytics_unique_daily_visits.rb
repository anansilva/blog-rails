class ChangeVisitorIpNullOnAnalyticsUniqueDailyVisits < ActiveRecord::Migration[6.0]
  def change
    change_column_null :analytics_unique_daily_visits, :visitor_ip, null: true
  end
end
