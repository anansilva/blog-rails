describe Admin::PostsController do
  let(:user) { create(:user) }

  describe '#new' do
    context 'when the user is logged in' do
      before { session[:user_id] = user.id }

      it 'responds successfully' do
        get :new

        expect(response.status).to eq(200)
      end
    end

    context 'when user is not logged in' do
      it 'should redirect to the login page' do
        get :new

        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe '#create' do
    context 'when the user is logged in' do
      before { session[:user_id] = user.id }

      let(:image_file) do
        Rack::Test::UploadedFile.new("#{::Rails.root}/spec/fixtures/abstract-done.png", 'image/png')
      end

      let(:post_params) do
        { title: 'Rspec', body: 'This post is about rspec',
          intro: 'Improve your test suite', cover_image: image_file,
          tags: 'ruby, rails' }
      end

      it 'responds successfully' do
        post :create, params: { post: post_params }

        expect(response.status).to eq(302)
      end

      it 'creates a Post with an ActionText body' do
        post :create, params: { post: post_params }

        created_post = Post.last

        expect(created_post.title).to eq('Rspec')
        expect(created_post.status).to eq('draft')
        expect(created_post.intro).to eq('Improve your test suite')
        expect(created_post.body.body.to_html).to eq('This post is about rspec')
        expect(created_post.cover_image).to be_present
      end

      it 'calls the UpdatePostTags service' do
        post :create, params: { post: post_params }

        created_post = Post.last

        expect(created_post.tags.pluck(:name)).to match_array(%w[ruby rails])
      end

      it 'redirects to the admin posts page' do
        post :create, params: { post: post_params }

        created_post = Post.last

        expect(response).to redirect_to(admin_post_path(created_post))
      end
    end
  end

  describe '#edit' do
    let(:post) { create(:post) }

    context 'when the user is logged in' do
      before { session[:user_id] = user.id }

      it 'redirects to the edit page' do
        get :edit, params: { id: post.slug }

        expect(response.status).to eq(200)
      end
    end
  end

  describe '#update' do
    let(:post) do
      create(:post, title: 'Rspec tips', body: 'Here are some tips')
    end

    context 'when the user is logged in' do
      before { session[:user_id] = user.id }

      it 'updates the post when updating title' do
        new_title = 'this is a new title'

        put :update, params: { id: post.slug, post: { title: new_title } }

        expect(post.reload.title).to eq('this is a new title')
      end

      it 'updates the post when updating body' do
        new_body = 'this is a new body'

        put :update, params: { id: post.id, post: { body: new_body } }

        expect(post.reload.body.body.to_html).to eq('this is a new body')
      end

      it 'calls the UpdatePostTags service' do
        new_body = 'this is a new body'

        allow(::Tags::UpdatePostTags).to receive(:call)

        put :update, params: { id: post.id, post: { body: new_body, tags: 'ruby' } }

        expect(::Tags::UpdatePostTags).to have_received(:call).with(post, ['ruby'])
      end
    end
  end

  describe '#destroy' do
    let(:post) { create(:post) }
    let(:tag) { create(:tag, name: 'testing') }

    before 'add tags to the post' do
      create(:tag_post, tag: tag, post: post)
    end

    context 'when the user is logged in' do
      before { session[:user_id] = user.id }

      it 'deletes a given post' do
        delete :destroy, params: { id: post.id }

        expect(Post.count).to eq(0)
      end

      it 'redirects to the index page' do
        delete :destroy, params: { id: post.id }

        expect(response.status).to eq(302)
      end
    end
  end

  describe '#show' do
    let(:post) { create(:post) }

    it 'responds successfully' do
      get :show, params: { id: post.id }

      expect(response.status).to eq(302)
    end
  end

  describe '#publish' do
    let(:post) { create(:post, status: 'draft') }

    before { session[:user_id] = user.id }

    it 'updates the post status to publish' do
      put :publish, params: { id: post.id }

      expect(post.reload.status).to eq('published')
    end
  end

  describe '#unpublish' do
    let(:post) { create(:post, status: 'published') }

    before { session[:user_id] = user.id }

    it 'updates the post status to draft' do
      put :unpublish, params: { id: post.id }

      expect(post.reload.status).to eq('draft')
    end
  end

  describe '#index' do
    before do
      session[:user_id] = user.id
    end

    it 'responds with draft and published posts' do
      get :index

      expect(response.status).to eq(200)
    end
  end
end
