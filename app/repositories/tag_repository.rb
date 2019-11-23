class TagRepository
  class << self
    def create_tag(tag_name)
      return unless tag_name.present?

      Tag.find_or_create_by(name: tag_name)
    end
  end
end
