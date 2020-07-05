class AddUserAgentToAnalyticsUniqueDailyVisits < ActiveRecord::Migration[6.0]
  def change
    add_column :analytics_unique_daily_visits, :user_agent, :string, null: false
  end
end
