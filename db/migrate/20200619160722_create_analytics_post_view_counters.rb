class CreateAnalyticsPostViewCounters < ActiveRecord::Migration[6.0]
  def change
    create_table :analytics_post_view_counters do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :count, default: 0, null: false

      t.timestamps
    end
  end
end
