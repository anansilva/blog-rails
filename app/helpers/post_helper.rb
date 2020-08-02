module PostHelper
  def twitter_share_url(post)
    twitter_url = "https://twitter.com/intent/tweet?url="
    twitter_url + post_url(post) + "&text=" + post.intro
  end
end
