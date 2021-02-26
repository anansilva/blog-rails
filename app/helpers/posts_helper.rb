module PostsHelper
  def active_tag(name)
    'text-gray-900' if params[:tag] == name
  end

  def hover_tag(name)
    'hover:text-gray-700' unless params[:tag] == name
  end

  def all_tag
    return 'text-gray-900' unless params[:tag].present?

    'hover:text-gray-700'
  end

  def link_to_post(post)
    return admin_post_path(post) if current_user

    post_path(post) if post.published?
  end

  def all_posts
    return admin_posts_path if current_user

    posts_path
  end

  def filter_posts(tag_name)
    return admin_posts_path(tag: tag_name) if current_user

    posts_path(tag: tag_name)
  end

  def markdown_to_html(text)
    options = %i[hard_wrap autolink no_intra_emphasis fenced_code_blocks]
    Markdown.new(text, *options).to_html.html_safe
  end
end
