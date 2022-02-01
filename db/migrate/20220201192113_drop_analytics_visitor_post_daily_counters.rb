class DropAnalyticsVisitorPostDailyCounters < ActiveRecord::Migration[6.1]
  def change
    drop_table :analytics_visitor_post_daily_counters
  end
end
