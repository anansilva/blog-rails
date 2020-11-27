describe Services::Analytics::VisitsStats do
  before do
    create(:unique_daily_visit, day: Date.today, visitor_ip: '::1',
           country: 'Portugal', device: 'desktop', referer: 'facebook',
           user_agent: '')
    create(:unique_daily_visit, day: Date.yesterday, visitor_ip: '::4',
           country: 'Spain', device: 'desktop', referer: 'facebook',
           user_agent: '')
    create(:unique_daily_visit, day: Date.yesterday, visitor_ip: '::2',
           country: 'USA', device: 'desktop', referer: 'twitter.com',
           user_agent: '')
    create(:unique_daily_visit, day: 3.days.ago, visitor_ip: '::2',
           country: 'USA', device: 'mobile', referer: 'google.com',
           user_agent: '')
  end

  it 'should build a hash with visits stats' do
    result = described_class.call

    expect(result).to match({
      total_unique_visits: 4,
      visits_per_country: { 'Portugal' => 1, 'Spain' => 1, 'USA' => 2 },
      visits_per_device: { 'desktop' => 3, 'mobile' => 1 },
      visits_per_referer: { 'facebook' => 2, 'twitter.com' => 1, 'google.com' => 1 }
    })
  end
end
