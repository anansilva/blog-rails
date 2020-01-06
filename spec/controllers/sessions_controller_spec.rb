describe SessionsController do
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
        expect(response.status).to eq(302)
      end
    end
  end
end
