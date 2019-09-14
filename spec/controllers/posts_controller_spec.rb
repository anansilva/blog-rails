require 'rails_helper'

describe PostsController do
  describe '#index' do
    before do
      create(:post, title: 'Sample title')
      create(:post, title: 'My Post title')
    end

    context 'when requesting in html format' do
      before { get :index }

      it 'responds successfully' do
        expect(response.status).to eq(200)
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
    let(:post) { create(:post, title: 'This is my selected post') }

    context 'when requesting in html format' do
      before { get :show, params: { id: post.id } }

      it 'responds successfully' do
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

  describe '#new' do
    it 'responds successfully' do
      get :new
      expect(response.status).to eq(200)
    end
  end
end