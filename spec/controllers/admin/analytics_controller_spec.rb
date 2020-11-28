describe Admin::AnalyticsController do
  describe '#index' do
    it 'responds successfully' do
      expect(Services::Analytics::VisitsStats).to receive(:call)
      expect(Services::Analytics::PostsStats).to receive(:call)

      get :index

      expect(response.status).to eq(200)
    end
  end
end
