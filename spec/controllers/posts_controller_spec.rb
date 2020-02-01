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
    let(:post) { create(:post, status: 'published') }

    context 'when requesting in html format' do
      it 'responds successfully' do
        get :show, params: { id: post.id }

        expect(response.status).to eq(200)
      end

      context 'when post is draft' do
        let(:post) { create(:post, status: 'draft') }

        it 'returns a 404 response' do
          get :show, params: { id: post.id }

          expect(response.status).to eq(404)
        end
      end
    end

    context 'when requesting in json format' do
      before { get :show, params: { id: post.id }, format: :json }

      it 'responds successfully' do
        expect(response.status).to eq(200)
      end
    end
  end
end
