module Pagination
  def paginate(collection:, params: {})
    pagination = Services::Pagination.new(params.merge(count: collection.size))
    [
      pagination,
      pagination_items(collection, pagination)
    ]
  end

  private

  def pagination_items(collection, pagination)
    collection.limit(pagination.per_page).offset(pagination.offset)
  end
end
