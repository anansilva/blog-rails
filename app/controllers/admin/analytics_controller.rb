module Admin
  class AnalyticsController < ApplicationController
    def index
      @analytics = Services::Analytics::VisitsStats.call
    end
  end
end
