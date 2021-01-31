require 'aws-sdk-s3'

SitemapGenerator::Sitemap.default_host = "http://ananunesdasilva.com"
SitemapGenerator::Sitemap.public_path = 'tmp/sitemap'

SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(Rails.application.credentials.dig(:aws, :prod, :sitemap_bucket),
                                                                        aws_access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
                                                                        aws_secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
                                                                        aws_region: Rails.application.credentials.dig(:aws, :region)
                                                                       )
SitemapGenerator::Sitemap.sitemaps_host = "https://#{Rails.application.credentials.dig(:aws, :prod, :sitemap_bucket)}.s3.#{Rails.application.credentials.dig(:aws, :region)}.amazonaws.com"

SitemapGenerator::Sitemap.create do
  "https://www.ananunesdasilva.com/about"
  "https://www.ananunesdasilva.com/posts"

  Post.find_each do |post|
    add "https://www.ananunesdasilva.com/posts/#{post.slug}", :lastmod => post.updated_at
  end
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
end
