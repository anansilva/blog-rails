# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Post.create(
  title: 'Rspec tips',
  intro: 'Lorem ipsum is placeholder text commonly used in the graphic, print,
          and publishing industries for previewing layouts and visual mockups.',
  body: 'aliquam faucibus purus in massa tempor nec feugiat nisl pretium fusce
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
         velit aliquet sagittis id consectetur purus',
  cover_image: Rack::Test::UploadedFile.new("#{::Rails.root}/spec/fixtures/abstract-done.png", 'image/png')
)

Post.create(
  title: 'The power of indexing',
  intro: 'Lorem ipsum is placeholder text commonly used in the graphic, print,
          and publishing industries for previewing layouts and visual mockups.',
  body:  'aliquam faucibus purus in massa tempor nec feugiat nisl pretium fusce
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
         velit aliquet sagittis id consectetur purus',
  cover_image: Rack::Test::UploadedFile.new("#{::Rails.root}/spec/fixtures/abstract-done.png", 'image/png')
)
