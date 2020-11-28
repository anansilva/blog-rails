module Services
  module Analytics
    class VisitsStats
      include Services::Callable

      def result
        {
          total_unique_visits: total_unique_visits,
          visits_per_country: visits_per_country,
          visits_per_device: visits_per_device,
          visits_per_referer: visits_per_referer
        }
      end

      private

      def total_unique_visits
        ::Analytics::UniqueDailyVisit.count
      end

      def visits_per_country
        run_sql('country').entries
      end

      def visits_per_device
        run_sql('device').entries
      end

      def visits_per_referer
        run_sql('referer').entries
      end

      def run_sql(column)
        sql = build_sql(column)

        ActiveRecord::Base
          .connection
          .execute(Arel.sql(sql))
      end

      def build_sql(column)
        <<-SQL
            SELECT #{column}, COUNT(id) AS views
            FROM analytics_unique_daily_visits
            GROUP BY #{column}
            ORDER BY #{column} ASC NULLS LAST, COUNT(id) DESC
        SQL
      end
    end
  end
end
