describe PostsController do
  describe '#index' do
    before do
      create(:post)
      create(:post)
    end

    context 'when requesting in html format' do
      before do
        allow(Query::Posts).to receive(:call).and_call_original
        allow(::EventSourcing::PublishService).to receive(:execute!)

        get :index
      end

      it 'responds successfully' do
        expect(response.status).to eq(200)
      end

      it 'calls Query::Post' do
        expect(Query::Posts).to have_received(:call)
      end

      it 'calls the publish service' do
        payload = {
          page: "http://test.host/",
          ip_address: '0.0.0.0',
          user_agent: 'Rails Testing',
          referer: nil
        }

        expect(::EventSourcing::PublishService).to have_received(:execute!)
          .with('viewed_page', payload, 'posts')
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

        it 'calls the publish service' do
          payload = {
            page: "http://test.host/posts/#{post.id}",
            ip_address: '0.0.0.0',
            user_agent: 'Rails Testing',
            referer: nil
          }

          allow(::EventSourcing::PublishService).to receive(:execute!)

          get :show, params: { id: post.id }

          expect(::EventSourcing::PublishService).to have_received(:execute!)
            .with('viewed_page',
                  payload,
                  'post')
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
