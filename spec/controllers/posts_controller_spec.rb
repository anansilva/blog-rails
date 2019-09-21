require 'rails_helper'

describe PostsController do
  describe '#index' do
    before do
      create(:post)
      create(:post)
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
    let(:post) do
      create(:post, title: 'This is my selected post', body: 'this is my body')
    end

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

  describe '#create' do
    it 'responds successfully' do
      post :create, params: { post: { title: 'hey', body: 'to sexy for my shirt' } }

      expect(response.status).to eq(302)
    end

    it 'creates a Post with a body' do
      post :create, params: { post: { title: 'hey', body: 'to sexy for my shirt' } }

      expect(Post.last.title).to eq('hey')
      expect(Post.last.body.class).to eq(ActionText::RichText)
    end
  end
  
  describe '#edit' do
    let(:post) { create(:post) }

    it 'redirects to the edit page' do
      get :edit, params: { id: post.id }

      expect(response.status).to eq(302)
    end
  end

  describe '#update' do
    let(:post) { create(:post, title: 'current title', body: 'your body is a wonderland') }

    it 'updates the post' do
      put :update, params: { id: post.id, post: { title: 'this is a new title'} }

      expect(post.reload.title).to eq('this is a new title')
    end
  end
end
