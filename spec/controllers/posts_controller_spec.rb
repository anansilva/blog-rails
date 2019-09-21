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
    let(:post) { create(:post) }

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
    post_params = { title: 'hey', body: 'to sexy for my shirt' }

    it 'responds successfully' do
      post :create, params: { post: post_params }

      expect(response.status).to eq(302)
    end

    it 'creates a Post with an ActionText body' do
      post :create, params: { post: post_params }

      expect(Post.last.title).to eq('hey')
      expect(Post.last.body.class).to eq(ActionText::RichText)
      expect(Post.last.body.body.to_html).to eq('to sexy for my shirt')
    end
  end

  describe '#edit' do
    let(:post) { create(:post) }

    it 'redirects to the edit page' do
      get :edit, params: { id: post.id }

      expect(response.status).to eq(200)
    end
  end

  describe '#update' do
    let(:post) do
      create(:post, title: 'current title', body: 'your body is a wonderland')
    end

    it 'updates the post when updating title' do
      new_title = 'this is a new title'

      put :update, params: { id: post.id, post: { title: new_title } }

      expect(post.reload.title).to eq('this is a new title')
    end

    it 'updates the post when updating body' do
      new_body = 'this is a new body'

      put :update, params: { id: post.id, post: { body: new_body } }

      expect(post.reload.body.body.to_html).to eq('this is a new body')
    end
  end

  describe '#destroy' do
    let(:post) { create(:post) }

    it 'deletes a given post' do
      delete :destroy, params: { id: post.id }

      expect { post.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'redirects to the index page' do
      delete :destroy, params: { id: post.id }

      expect(response.status).to eq(302)
    end
  end
end
