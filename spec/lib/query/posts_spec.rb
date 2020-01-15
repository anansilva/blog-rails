describe Query::Posts do
  before 'create posts and tags' do
    create(:post, status: 'published')

    create(:post, status: 'published').tap do |post|
      create(:tag, name: 'ruby').tap do |tag|
        create(:tag_post, tag: tag, post: post)
      end
    end
  end

  context 'when tag is empty' do
    it 'returns all published posts' do
      filtered_posts = described_class.call

      expect(filtered_posts.count).to eq(2)
    end
  end

  context 'when tag exists' do
    it 'returns only the published posts that are related to the tag' do
      filtered_posts = described_class.call('ruby')

      expect(filtered_posts.count).to eq(1)
    end
  end

  context 'when there is a draft post' do
    before { create(:post, status: 'draft') }

    it 'returns only the published posts' do
      filtered_posts = described_class.call

      expect(filtered_posts.count).to eq(2)
    end
  end
end
