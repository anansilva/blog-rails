module Tags
  class UpdatePostTags
    def initialize(post, tags)
      @post = post
      @tags = tags
    end

    def self.execute!(post, tags)
      new(post, tags).update_tags
    end

    def update_tags
      add_tags
      remove_tags
    end

    private

    def add_tags
      return unless tags_to_add?

      tags_to_add.each do |tag_name|
        ActiveRecord::Base.transaction do
          tag = Tag.find_or_create_by(name: tag_name)
          TagPost.find_or_create_by(post: @post, tag: tag)
        end
      end
    end

    def remove_tags
      return unless tags_to_remove?

      tags_to_remove.each do |tag_name|
        ActiveRecord::Base.transaction do
          tag = Tag.find_by(name: tag_name)
          TagPost.where(post: @post, tag: tag).destroy_all
          tag.destroy unless tags_in_use_by_other_posts.include?(tag_name)
        end
      end
    end

    def tags_in_use_by_other_posts
      Tag
        .joins('left outer join tag_posts on tag_posts.tag_id = tags.id')
        .where.not('tag_posts.post_id' => @post.id)
        .pluck(:name)
    end

    def tags_to_add
      @tags_to_add ||= @tags - post_tags
    end

    def tags_to_add?
      tags_to_add.present?
    end

    def tags_to_remove
      @tags_to_remove ||= post_tags - @tags
    end

    def tags_to_remove?
      tags_to_remove.present?
    end

    def post_tags
      @post_tags ||= @post.tags.pluck(:name)
    end
  end
end
