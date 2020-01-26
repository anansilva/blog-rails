module MetaTagsHelper
  def meta_title(title)
    content_for(:title, title) || 'Web development personal blog'
  end

  def meta_description(description)
    content_for(:meta_description, description)  || 'Content on web development mainly focused on ruby and rails'
  end

  def meta_keywords(keywords)
    content_for(:meta_keywords, keywords) || 'web development, ruby, rails, tools, tdd, rspec'
  end
end
