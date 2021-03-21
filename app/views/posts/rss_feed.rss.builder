xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Ana Nunes da Silva"
    xml.description "A personal blog on web development mainly focused on ruby and rails"
    xml.link root_url

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.intro
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end
