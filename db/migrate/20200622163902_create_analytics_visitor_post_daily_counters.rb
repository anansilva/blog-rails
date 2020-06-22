class CreateAnalyticsVisitorPostDailyCounters < ActiveRecord::Migration[6.0]
  def change
    create_table :analytics_visitor_post_daily_counters do |t|
      t.references :post, null: false
      t.string     :visitor_ip, null: false
      t.date       :day, null: false
      t.integer    :views_count, defaut: 0, null: false

      t.timestamps
    end

    add_index :analytics_visitor_post_daily_counters, %i[post_id visitor_ip day],
              unique: true,
              name: 'unique_index_analytics_visitor_post_daily_counters'
  end
end
