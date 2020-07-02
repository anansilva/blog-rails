module Analytics
  class VisitorPostDailyCounter < ApplicationRecord
    belongs_to :post
  end
end
