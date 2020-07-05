class ChangeVisitorIpNullOnAnalyticsVistorPostDailyCounters < ActiveRecord::Migration[6.0]
  def change
    change_column_null :analytics_visitor_post_daily_counters, :visitor_ip, null: true
  end
end
