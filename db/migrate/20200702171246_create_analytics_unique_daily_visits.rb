class CreateAnalyticsUniqueDailyVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :analytics_unique_daily_visits do |t|
      t.string     :visitor_ip, null: false
      t.string     :country
      t.string     :browser
      t.string     :device
      t.date       :day, null: false

      t.timestamps
    end

    add_index :analytics_unique_daily_visits, %i[visitor_ip country browser device day],
              unique: true,
              name: 'unique_index_analytics_unique_daily_visits'
  end
end
