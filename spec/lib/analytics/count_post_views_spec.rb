describe Analytics::CountPostViews do
  let(:post) { create(:post) }

  context 'views registered' do
    before 'register post views' do
      create(:visitor_post_daily_counter, visitor_ip: '148.63.78.99',
             post: post, views_count: 2, day: Date.today)
      create(:visitor_post_daily_counter, visitor_ip: '111.63.78.99',
             post: post, views_count: 2, day: Date.today)
    end

    it 'counts the total post views' do
      result = described_class.call(post)

      expect(result[:total_views]).to eq(4)
    end

    it 'counts the unique post views' do
      result = described_class.call(post)

      expect(result[:unique_total_views]).to eq(2)
    end
  end

  context 'no views registered' do
    it 'totals are 0' do
      result = described_class.call(post)

      expect(result[:total_views]).to eq(0)
      expect(result[:unique_total_views]).to eq(0)
    end
  end
end
