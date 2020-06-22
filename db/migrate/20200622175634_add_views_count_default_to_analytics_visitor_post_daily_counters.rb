class AddViewsCountDefaultToAnalyticsVisitorPostDailyCounters < ActiveRecord::Migration[6.0]
  def change
    change_column_default :analytics_visitor_post_daily_counters,:views_count, from: nil, to: 0
  end
end
