module Services
  class Pagination
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
