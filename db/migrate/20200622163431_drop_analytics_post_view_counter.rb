class DropAnalyticsPostViewCounter < ActiveRecord::Migration[6.0]
  def change
    drop_table :analytics_post_view_counters
  end
end
