describe PostsController do
  describe '#index' do
    let(:publisher_klass) { ::EventSourcing::Publishers::HomePageViewed }

    before do
      create(:post)
      create(:post)
    end

    context 'when requesting in html format' do
      before do
        allow(Query::Posts).to receive(:call).and_call_original
        allow(publisher_klass).to receive(:execute!)

        get :index
      end

      it 'responds successfully' do
        expect(response.status).to eq(200)
      end

      it 'calls Query::Post' do
        expect(Query::Posts).to have_received(:call)
      end

      it 'calls the publish service' do
        expect(publisher_klass).to have_received(:execute!).with(request, nil)
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
    let(:publisher_klass) { ::EventSourcing::Publishers::PostViewed }

    context 'when the post is published' do
      let(:post) { create(:post, status: 'published') }

      context 'when requesting in html format' do
        it 'responds successfully' do
          get :show, params: { id: post.id }

          expect(response.status).to eq(200)
        end

        it 'calls the publish service' do
          allow(publisher_klass).to receive(:execute!)

          get :show, params: { id: post.id }

          expect(publisher_klass).to have_received(:execute!).with(request, post)
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
end
