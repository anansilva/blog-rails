require 'rails_helper'

describe PostsController do
  context 'when requesting in html format' do
    before do
      create(:post, title: 'Sample title')
      create(:post, title: 'My Post title')
    end

    describe '#index' do
      it 'responds successfully' do
        get :index
        expect(response.status).to eq(200)
      end
    end
  end

  context 'when requesting in json format' do
    it 'responds successfully' do
      get :index, format: :json
      binding.pry
      expect(response.status).to eq(200)
    end

    xit 'shows all posts in a json' do
      get :index, format: :json
    end
  end
end
