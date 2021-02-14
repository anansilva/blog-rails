desc 'cross-post to dev.to'
task :cross_post, [:post_id] => [:environment] do |_, args|
  post = Post.find(args[:post_id])

  puts "Posting #{post.title} on dev.to..."

  Services::CrossPostDevTo.call(post)

  puts 'Done!'
end
