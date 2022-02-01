class DropAnalyticsUniqueDailyVisits < ActiveRecord::Migration[6.1]
  def change
    drop_table :analytics_unique_daily_visits
  end
end
