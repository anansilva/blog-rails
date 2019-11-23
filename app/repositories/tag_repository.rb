class TagRepository
  class << self
    def create_bulk(tags = [])
      return if tags.empty?

      if attrs_valid?(tags)
        tags.each { Tag.create(tags) }
      else
        raise ::Errors::InvalidAttributes unless attrs_valid?(tags)
      end
    end

    private

    def attrs_valid?(tags)
      tags.flat_map(&:keys).uniq == [:name]
    end
  end
end
