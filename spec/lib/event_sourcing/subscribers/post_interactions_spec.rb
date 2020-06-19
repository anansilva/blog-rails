describe EventSourcing::Subscribers::PostInteractions do
  context 'when post is viewed for the first time' do
    it 'creates a new post view counter and increments it by one' do
      post = create(:post, title: 'my first post')

      event = {
        page: '',
        ip_adress: '',
        user_agent: '',
        referer: '',
        post_id: post.id,
        post_title: post.title
      }

      described_class.new.call(event)
      post_counter = ::Analytics::PostViewCounter.find_by(post_id: post.id)

      expect(::Analytics::PostViewCounter.count).to eq(1)
      expect(post_counter.reload.count).to eq(1)
    end
  end

  context 'when post has been viewed at least once already' do
    it 'increases post views counter by one' do
      post = create(:post, title: 'my first post')
      post_counter = ::Analytics::PostViewCounter.create(post_id: post.id, count: 1)

      event = {
        page: '',
        ip_adress: '',
        user_agent: '',
        referer: '',
        post_id: post.id,
        post_title: post.title
      }

      described_class.new.call(event)

      expect(::Analytics::PostViewCounter.count).to eq(1)
      expect(post_counter.reload.count).to eq(2)
    end
  end

  context 'when other posts have also been viewed' do
    it 'does not update the other posts counters' do
      rails_post = create(:post, title: 'my first post')
      rails_post_counter = ::Analytics::PostViewCounter.create(post_id: rails_post.id, count: 1)

      vim_post = create(:post, title: 'my second post')

      event = {
        page: '',
        ip_adress: '',
        user_agent: '',
        referer: '',
        post_id: vim_post.id,
        post_title: vim_post.title
      }

      described_class.new.call(event)

      vim_post_counter = ::Analytics::PostViewCounter.find_by(post_id: vim_post.id)

      expect(rails_post_counter.reload.count).to eq(1)
      expect(vim_post_counter.reload.count).to eq(1)
    end
  end
end
