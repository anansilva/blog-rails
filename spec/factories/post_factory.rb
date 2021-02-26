FactoryBot.define do
  factory :post do
    title { 'Sample post title' }
    intro { 'Intro' }
    body { '## Sample post body' }
    cover_image {  Rack::Test::UploadedFile.new("#{::Rails.root}/spec/fixtures/abstract-done.png", 'image/png') }
  end
end
