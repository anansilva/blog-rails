class AddSharesCountToAnalyticsVisitorPostDailyCounters < ActiveRecord::Migration[6.0]
  def change
    add_column :analytics_visitor_post_daily_counters, :shares_count, :integer, default: 0
  end
end
