describe SessionsController do
  describe '#new' do
    it 'redirects to the login page' do
      get :new

      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    context 'when the login data is valid' do
      before do
        create(:user, email: 'user@test.com', password: '$p@ssw0rd')

        post :create, params: { email: 'user@test.com', password: '$p@ssw0rd'}
      end

      it 'adds the user id to the rails session hash' do
        expect(session[:user_id]).to eq(User.first.id)
      end

      it 'redirects to the new post page' do
        expect(response).to redirect_to(new_admin_post_path)
      end
    end

    context 'when the login data is invalid' do
      before do
        create(:user, email: 'anabanana@test.com', password: 'banana')

        post :create, params: { email: 'user@test.com', password: '$p@ssw0rd'}
      end

      it 'does not add the user id to the rails session hash' do
        expect(session[:user_id]).to eq(nil)
      end

      it 'redirects to the sessions page' do
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe '#destroy' do
    before do
      session[:user_id] = 1
    end

    it 'empties the rails session hash' do
      expect(session[:user_id]).to eq(1)

      delete :destroy

      expect(session[:user_id]).to eq(nil)
    end

    it 'redirects to the posts page' do
      delete :destroy

      expect(response).to redirect_to(posts_path)
    end
  end
end
