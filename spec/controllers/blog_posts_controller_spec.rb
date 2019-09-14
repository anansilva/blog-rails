require 'rails_helper'

describe BlogPostsController do
  describe '#index' do
    before do
      create(:blog_post, title: 'Sample title')
      create(:blog_post, title: 'My Post title')
    end

    context 'when requesting in html format' do
      before { get :index }

      it 'responds successfully' do
        expect(response.status).to eq(200)
      end

      it 'renders an html template' do
        assert_template 'blog_posts/index'
      end

      it 'gets all blog posts' do
        assert_equal BlogPost.all, assigns(:posts)
      end
    end

    context 'when requesting in json format' do
      before { get :index, format: :json }

      it 'responds successfully' do
        expect(response.status).to eq(200)
      end

      it 'renders a json template' do
        assert_template 'blog_posts/index'
      end
    end
  end

  describe '#show' do
    let(:blog_post) { create(:blog_post, title: 'This is my selected post') }

    context 'when requesting in html format' do
      before { get :show, params: { id: blog_post.id } }

      it 'responds successfully' do
        expect(response.status).to eq(200)
      end

      it 'renders an html template' do
        assert_template 'blog_posts/show'
      end

      it 'finds the selected blog post' do
        assert_equal blog_post, assigns(:post)
      end
    end

    context 'when requesting in json format' do
      before { get :show, params: { id: blog_post.id }, format: :json }

      it 'responds successfully' do
        expect(response.status).to eq(200)
      end

      it 'renders a json template' do
        assert_template 'blog_posts/show'
      end
    end
  end
end
