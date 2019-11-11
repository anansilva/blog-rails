class TagPost < ApplicationRecord
  belongs_to :tag
  belongs_to :post
end
