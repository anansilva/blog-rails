module Services
  class MountShareUrl
    include ::Services::Callable

    receive :post, :post_url, :social_media

    BASE_URL = {
      twitter: "https://twitter.com/intent/tweet?url=",
      facebook: "http://www.facebook.com/sharer.php?u=",
      linkedin: "https://www.linkedin.com/shareArticle?mini=true&url="
    }

    TEXT_PARAM = {
      twitter: "&text=",
      facebook: "&p[title]=",
      linkedin: "&text="
    }

    def result
      BASE_URL[@social_media.to_sym] +
        @post_url +
        TEXT_PARAM[@social_media.to_sym] +
        @post.intro
    end
  end
end
