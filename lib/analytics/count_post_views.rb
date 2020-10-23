module Analytics
  class CountPostViews
    include ::Services::Callable

    receive :post

    def result
      {
        total_views: count_total_views,
        unique_total_views: count_unique_total_views
      }
    end

    private

    def count_total_views
      ::Analytics::VisitorPostDailyCounter.sum(:views_count)
    end

    def count_unique_total_views
      ::Analytics::VisitorPostDailyCounter
        .select(:visitor_ip)
        .distinct
        .count
    end
  end
end
