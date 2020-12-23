describe PostsController do
  describe '#index' do
    before do
      create(:post)
      create(:post)
    end

    context 'when requesting in html format' do
      before do
        allow(Query::Posts).to receive(:call).and_call_original

        get :index
      end

      it 'responds successfully' do
        expect(response.status).to eq(200)
      end

      it 'calls Query::Post' do
        expect(Query::Posts).to have_received(:call)
      end
    end

    context 'when requesting in json format' do
      before { get :index, format: :json }

      it 'responds successfully' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#show' do
    context 'when the post is published' do
      let(:post) { create(:post, status: 'published') }

      context 'when requesting in html format' do
        it 'responds successfully' do
          get :show, params: { id: post.id }

          expect(response.status).to eq(200)
        end
     end

      context 'when requesting in json format' do
        before { get :show, params: { id: post.id }, format: :json }

        it 'responds successfully' do
          expect(response.status).to eq(200)
        end
      end
    end

    context 'when post is draft' do
      let(:post) { create(:post, status: 'draft') }

      it 'throws an ActiveRecord::RecordNotFound error' do
        expect { get :show, params: { id: post.id } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#share' do
    let(:post) { create(:post, status: 'published') }

    it 'redirects to the social media page' do
      get :share, params: { id: post.id, social_media: 'twitter' }

      expect(response.status).to eq(302)
    end

    it 'calls the mount share url service' do
      post_url = "http://localhost/posts/sample-post-title"

      allow(::Services::MountShareUrl).to receive(:call).and_return({})

      get :share, params: { id: post.id, social_media: 'twitter' }

      expect(::Services::MountShareUrl).to have_received(:call).with(post, post_url, 'twitter')
    end
  end
end
