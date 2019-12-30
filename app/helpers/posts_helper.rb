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
end
