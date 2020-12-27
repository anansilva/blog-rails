module ApplicationHelper
  def html_title
    return @post.title if @post

    return 'About me' if current_page?(about_path)
    return 'Ana Nunes da Silva' if current_page?(home_path)
    return 'Posts' if current_page?(posts_path)
    return "Posts: #{params[:tag]}" if current_page?(posts_path) && params[:tag]

    'Ana\'s tech blog'
  end
end

