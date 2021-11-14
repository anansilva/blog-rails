module Pagination
  extend ActiveSupport::Concern

  def paginate(query:, page:)
    query
  end
end
