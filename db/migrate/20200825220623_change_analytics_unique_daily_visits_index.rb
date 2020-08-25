class ChangeAnalyticsUniqueDailyVisitsIndex < ActiveRecord::Migration[6.0]
  def change
    remove_index :analytics_unique_daily_visits,
              %i[visitor_ip country browser device day]

    add_index :analytics_unique_daily_visits,
              %i[visitor_ip day],
              unique: true,
              name: 'unique_index_analytics_unique_daily_visits'
  end
end
