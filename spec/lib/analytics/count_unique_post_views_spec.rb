describe Analytics::CountUniquePostViews do
  let(:post) { create(:post) }

  before 'register post views' do
    create(:visitor_post_daily_counter, visitor_ip: '148.63.78.99',
           post: post, views_count: 2, day: Date.today)
    create(:visitor_post_daily_counter, visitor_ip: '111.63.78.99',
           post: post, views_count: 2, day: Date.today)
  end

  it 'counts the total post views' do
    result = described_class.call(post)

    expect(result[:total_views]).to eq(4)
    expect(result[:unique_total_views]).to eq(2)
  end
end
