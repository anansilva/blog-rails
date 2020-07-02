module Analytics
  class PostViewCounter < ApplicationRecord
    belongs_to :post
  end
end
