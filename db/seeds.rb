User.destroy_all
Tag.destroy_all
Post.destroy_all

User.create(email: 'ana@test.com', password: 'banana', password_confirmation: 'banana')

intro = <<-INTRO
Lorem ipsum is placeholder text commonly used in the graphic, print,
and publishing industries for previewing layouts and visual mockups.
INTRO

body = <<-BODY
aliquam faucibus purus in massa tempor nec feugiat nisl pretium fusce
id velit ut tortor pretium viverra suspendisse potenti nullam ac tortor
vitae purus faucibus ornare suspendisse sed nisi lacus sed viverra tellus
in hac habitasse platea dictumst vestibulum rhoncus est pellentesque elit
ullamcorper dignissim cras tincidunt lobortis feugiat vivamus at augue
eget arcu dictum varius duis at consectetur lorem donec massa sapien
faucibus et molestie ac feugiat sed lectus vestibulum mattis ullamcorper
velit sed ullamcorper morbi tincidunt ornare massa eget egestas purus
viverra accumsan in nisl nisi scelerisque eu ultrices vitae auctor eu augue
ut lectus arcu bibendum at varius vel pharetra vel turpis nunc eget lorem
dolor sed viverra ipsum nunc aliquet bibendum enim facilisis gravida neque
convallis a cras semper auctor neque vitae tempus quam pellentesque nec nam
aliquam sem et tortor consequat id porta nibh venenatis cras sed felis eget
velit aliquet sagittis id consectetur purus
BODY

6.times do
  Post.create(
    title: 'Rspec tips',
    intro: intro,
    body: body,
    cover_image: Rack::Test::UploadedFile.new("#{::Rails.root}/spec/fixtures/abstract-done.png", 'image/png'),
  )
end

%w[Testing Performance Ruby Rails Productivity].each do |tag_name|
  ActiveRecord::Base.transaction do
    Tag.create(name: tag_name).tap do |tag|
      TagPost.create(tag_id: tag.id, post_id: Post.all.sample.id)
    end
  end
end
