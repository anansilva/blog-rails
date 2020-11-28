module Services
  module Analytics
    class PostsStats
      include Services::Callable

      def result
        run_sql
      end

      private

      def run_sql
        sql = build_sql

        ActiveRecord::Base
          .connection
          .execute(Arel.sql(sql))
          .entries
      end

      def build_sql
        <<-SQL
            SELECT
              posts.slug,
              COUNT(DISTINCT analytics.visitor_ip) AS unique_views,
              SUM(analytics.views_count) AS total_views,
              SUM(analytics.shares_count) AS total_shares
            FROM analytics_visitor_post_daily_counters AS analytics
            INNER JOIN posts ON posts.id = analytics.post_id
            GROUP BY posts.slug
            ORDER BY COUNT(analytics.visitor_ip) DESC
        SQL
      end
    end
  end
end
