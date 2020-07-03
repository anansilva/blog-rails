class AddRefererToAnalyticsUniqueDailyVisits < ActiveRecord::Migration[6.0]
  def change
    add_column :analytics_unique_daily_visits, :referer, :string
  end
end
