module PostHelper
  def twitter_share_url(post)
    twitter_url = "https://twitter.com/intent/tweet?url="
    twitter_url + post_url(post) + "&text=" + post.intro
  end

  def facebook_share_url(post)
    facebook_url = "http://www.facebook.com/sharer.php?u="
    facebook_url + post_url(post) + "&p[title]=" + post.intro
  end

  def linkedin_share_url(post)
    linkedin_url = "https://www.linkedin.com/shareArticle?mini=true&url="
    linkedin_url + post_url(post) + "&text=" + post.intro
  end
end
