module Pagination
  def paginate(collection:, params: {})
    pagination = Services::Pagination.new(collection, params)

    [
      pagination.metadata,
      pagination.results
    ]
  end
end
