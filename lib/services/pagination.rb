module Services
  class Pagination
    DEFAULT = { page: 1, per_page: 6 }.freeze

    attr_reader :collection, :params

    def initialize(collection, params = {})
      @collection = collection
      @params = params.merge(count: collection.size)
    end

    def metadata
      @metadata ||= ViewModel::Pagination.new(params)
    end

    def results
      collection
        .limit(metadata.per_page)
        .offset(metadata.offset)
    end
  end
end
