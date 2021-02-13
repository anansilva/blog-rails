require 'aws-sdk-s3'

SitemapGenerator::Sitemap.default_host = "https://ananunesdasilva.com"
SitemapGenerator::Sitemap.public_path = 'tmp/sitemap'

SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(Rails.application.credentials.dig(:aws, :prod, :sitemap_bucket),
                                                                        aws_access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
                                                                        aws_secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
                                                                        aws_region: Rails.application.credentials.dig(:aws, :region)
                                                                       )
SitemapGenerator::Sitemap.sitemaps_host = "https://#{Rails.application.credentials.dig(:aws, :prod, :sitemap_bucket)}.s3.#{Rails.application.credentials.dig(:aws, :region)}.amazonaws.com"

SitemapGenerator::Sitemap.create do
  add '/about', priority: 1, changefreq: 'monthly'
  add '/posts', priority: 1, changefreq: 'monthly'

  Post.find_each do |post|
    add post_path(post), priority: 0.5, lastmod: post.updated_at, changefreq: 'monthly'
  end
end
