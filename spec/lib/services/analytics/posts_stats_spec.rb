describe Services::Analytics::PostsStats do
  let(:rails_post) { create(:post, slug: 'rails-post') }
  let(:rspec_post) { create(:post, slug: 'rspec-post') }

  before do
    create(:visitor_post_daily_counter, post: rails_post, day: Date.today, visitor_ip: '::1',
           views_count: 1, shares_count: 1)
    create(:visitor_post_daily_counter, post: rails_post, day: 2.days.ago, visitor_ip: '::1',
           views_count: 2, shares_count: 1)
    create(:visitor_post_daily_counter, post: rails_post, day: Date.today, visitor_ip: '::3',
           views_count: 2, shares_count: 1)
    create(:visitor_post_daily_counter, post: rspec_post, day: Date.today, visitor_ip: '::1',
           views_count: 1, shares_count: 1)
  end

  it 'should build a hash with all publish post stats' do
    result = described_class.call

    expect(result).to match_array([
      { "slug" => 'rails-post',
        "total_views" =>  5,
        "unique_views" => 2,
        "total_shares" => 3
      },
      { "slug" => 'rspec-post',
        "total_views" => 1,
        "unique_views" => 1,
        "total_shares" => 1
      }
    ])
  end
end
