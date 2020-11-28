module Admin
  class AnalyticsController < ApplicationController
    before_action :authenticate_user!

    def index
      @visits_stats = Services::Analytics::VisitsStats.call
      @posts_stats = Services::Analytics::PostsStats.call
    end
  end
end
