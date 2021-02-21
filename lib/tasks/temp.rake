desc 'migrate markdown_body to body'
task :migrate_markdown_body_to_body, [] => [:environment] do
  puts "Migrating data... "

  Post.all.each do |post|
    post.update!(body: post.markdown_body)
  end
end
